import 'dart:async';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_visibility_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_content.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_sliver_app_bar.dart';
import 'package:cportal_flutter/service_locator.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/only_selected_filters_service.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late ScrollController _scrollController;
  late TextEditingController _searchController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _searchController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).extension<CustomTheme>()!;
    _setupScrollController(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: theme.background,
        body: Stack(
          children: [
            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                slivers: [
                  // Поиск с фильтром.
                  ContactsSliverAppBar(
                    searchController: _searchController,
                    onFilterTap: _onFilterTap,
                    onSearch: _onSearchInput,
                    onSearchClear: _onSearchClear,
                  ),

                  ContactsContent(
                    scrollController: _scrollController,
                    sendFilters: () =>
                        _sendFilters(context, isFromRemove: true),
                  ),
                ],
              ),
            ),

            // Подложка фильтра Web.
            BlocBuilder<FilterVisibilityBloc, FilterVisibilityState>(
              builder: (_, state) {
                return state.isActive
                    ? GestureDetector(
                        onTap: _onApplyFilter,
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: theme.barrierColor,
                        ),
                      )
                    : const SizedBox();
              },
            ),

            // Фильтр Web.
            Align(
              alignment: Alignment.centerRight,
              child: FilterWeb(
                type: FilterType.contacts,
                onApply: _onApplyFilter,
                onClear: _onClearFilter,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _scrollController.dispose();
  }

  // Пагинация.
  Future<void> _setupScrollController(BuildContext context) async {
    final isConnected = await sl<INetworkInfo>().isConnected;
    _scrollController.addListener(() {
      if (_searchController.text.isEmpty) {
        if (_scrollController.position.atEdge) {
          if (_scrollController.position.pixels != 0) {
            if (isConnected) {
              BlocProvider.of<ContactsBloc>(context)
                  .add(const FetchContactsEvent());
            }
          }
        }
      }
    });
  }

  // Открывает фильтр.
  Future<void> _onFilterTap() async {
    if (!ResponsiveWrapper.of(context).isLargerThan(MOBILE)) {
      await showFilterMobile(
        context,
        onApply: _onApplyFilter,
        onClear: _onClearFilter,
        type: FilterType.contacts,
      ).whenComplete(() {
        _sendFilters(context);
      });
    } else {
      context.read<FilterVisibilityBloc>().add(
            const FilterChangeVisibilityEvent(
              isActive: true,
            ),
          );
    }
  }

  // Кнопка [Применить] фильтр.
  void _onApplyFilter() {
    if (ResponsiveWrapper.of(context).isLargerThan(TABLET)) {
      context
          .read<FilterVisibilityBloc>()
          .add(const FilterChangeVisibilityEvent(isActive: false));
    } else {
      Navigator.pop(context);
    }
  }

  // Кнопка [Очистить] фильтр.
  void _onClearFilter() {
    context.read<FilterContactsBloc>().add(FilterRemoveAllEvent());
    BlocProvider.of<ContactsBloc>(
      context,
      listen: false,
    ).add(
      const FetchContactsEvent(isFirstFetch: true),
    );
    context
        .read<FilterVisibilityBloc>()
        .add(const FilterChangeVisibilityEvent(isActive: false));
  }

  void _onSearchInput(String text) {
    final state = context.read<FilterContactsBloc>().state;

    BlocProvider.of<ContactsBloc>(
      context,
      listen: false,
    ).add(
      SearchContactsEvent(
        query: text,
        filters: (state is FilterLoadedState)
            ? OnlySelectedFiltersService.count(state.contactsFilters)
            : [],
      ),
    );
  }

  void _onSearchClear() {
    final state = context.read<FilterContactsBloc>().state;

    setState(() {
      _searchController.clear();
    });
    BlocProvider.of<ContactsBloc>(
      context,
      listen: false,
    ).add(
      SearchContactsEvent(
        query: '',
        filters: (state is FilterLoadedState)
            ? OnlySelectedFiltersService.count(state.contactsFilters)
            : [],
      ),
    );
  }

  // Получение контактов по выбранным фильтрам.
  void _sendFilters(BuildContext context, {bool isFromRemove = false}) {
    final state = context.read<FilterContactsBloc>().state;
    if (state is FilterLoadedState) {
      final onlySelectedFilters =
          OnlySelectedFiltersService.count(state.contactsFilters);

      if (onlySelectedFilters.isNotEmpty) {
        BlocProvider.of<ContactsBloc>(
          context,
          listen: false,
        ).add(
          SearchContactsEvent(
            query: '',
            filters: onlySelectedFilters,
          ),
        );
      } else {
        if (isFromRemove) {
          BlocProvider.of<ContactsBloc>(
            context,
            listen: false,
          ).add(
            const FetchContactsEvent(isFirstFetch: true),
          );
        }
      }
    }
  }
}
