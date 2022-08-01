import 'dart:async';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_visibility_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/only_selected_filters_service.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/contact_profile_pop_up.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list/contacts_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/selected_filters_view.dart.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    _setupScrollController(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: theme.background,
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: kIsWeb ? 12 : 11,
                  ),
                  Padding(
                    padding: getHorizontalPadding(context),
                    child: SearchWithFilter(
                      searchController: _searchController,
                      onSearch: (text) {
                        _onSearchInput(text);
                      },
                      onFilterTap: () async {
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
                      },
                    ),
                  ),

                  // Выбранные фильтры.
                  BlocBuilder<FilterContactsBloc, FilterState>(
                    builder: (context, state) {
                      if (state is FilterLoadedState) {
                        return SelectedFiltersView(
                          filters: state.contactsFilters,
                          onRemove: (item, i) async {
                            context.read<FilterContactsBloc>().add(
                                  FilterRemoveItemEvent(
                                    filterIndex: i,
                                    item: item,
                                  ),
                                );
                            await Future<dynamic>.delayed(
                              const Duration(milliseconds: 150),
                            );
                            _sendFilters(context, isFromRemove: true);
                          },
                        );
                      }

                      // TODO: отработать другие стейты.
                      return const SizedBox(height: 31);
                    },
                  ),
                  BlocBuilder<ContactsBloc, ContactsState>(
                    builder: (context, state) {
                      List<ProfileEntity> contacts = [];
                      if (state is ContactsLoadingState && state.isFirstFetch) {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is ContactsLoadingState) {
                        contacts = state.oldContacts;
                      }

                      if (state is ContactsLoadedState) {
                        contacts = state.contacts;
                      }

                      return contacts.isNotEmpty
                          ? Expanded(
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// [Не удалять, нужная фича]
                                    // Избранные.
                                    // if (state.favorites.isNotEmpty)
                                    //   Padding(
                                    //     padding: EdgeInsets.only(
                                    //       left: getSingleHorizontalPadding(
                                    //         context,
                                    //       ),
                                    //       bottom: 16,
                                    //     ),
                                    //     child: Favorites(
                                    //       items: state.favorites,
                                    //       onTap: (i) async {
                                    //         await _goToUserPage(
                                    //           contacts,
                                    //           i,
                                    //         );
                                    //       },
                                    //     ),
                                    //   ),

                                    // Колонка контактов.
                                    ContactsList(
                                      items: contacts,
                                      onTap: (i) async {
                                        await _goToUserPage(contacts, i);
                                      },
                                    ),

                                    const SizedBox(height: 42),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.emptySearch,
                                  style: theme.textTheme.px22.copyWith(
                                    color: theme.text?.withOpacity(0.5),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<FilterVisibilityBloc, FilterVisibilityState>(
              builder: (_, state) {
                return state.isActive
                    ? GestureDetector(
                        onTap: _onApplyFilter,
                        child: Container(
                          width: width,
                          height: height,
                          color: theme.barrierColor,
                        ),
                      )
                    : const SizedBox();
              },
            ),
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
  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_searchController.text.isEmpty) {
        if (_scrollController.position.atEdge) {
          if (_scrollController.position.pixels != 0) {
            BlocProvider.of<ContactsBloc>(context).add(const FetchContactsEvent());
          }
        }
      }
    });
  }

  // Навигация на страницу пользователя.
  Future<void> _goToUserPage(
    List<ProfileEntity> contacts,
    int i,
  ) async {
    if (ResponsiveWrapper.of(context).isDesktop) {
      await _showContactProfile(contacts, i);
    } else {
      GoRouter.of(context).pushNamed(
        NavigationRouteNames.contactProfile,
        params: {'fid': contacts[i].id},
      );
    }
  }

  // Кнопка [Применить] фильтр.
  void _onApplyFilter() {
    if (ResponsiveWrapper.of(context).isLargerThan(TABLET)) {
      context.read<FilterVisibilityBloc>().add(const FilterChangeVisibilityEvent(isActive: false));
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
    context.read<FilterVisibilityBloc>().add(const FilterChangeVisibilityEvent(isActive: false));
  }

  // Профиль пользователя для Web.
  Future<void> _showContactProfile(
    List<ProfileEntity> contacts,
    int i,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

        return StatefulBuilder(
          builder: (context, setState) {
            final width = MediaQuery.of(context).size.width;

            return Center(
              child: Container(
                width: width * 0.3,
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: ContactProfilePopUp(id: contacts[i].id),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _onSearchInput(
    String text,
  ) {
    final state = context.read<FilterContactsBloc>().state;

    BlocProvider.of<ContactsBloc>(
      context,
      listen: false,
    ).add(
      SearchContactsEvent(
        query: text,
        filters: (state is FilterLoadedState) ? OnlySelectedFiltersService.count(state.contactsFilters) : [],
      ),
    );
  }

  void _sendFilters(BuildContext context, {bool isFromRemove = false}) {
    final state = context.read<FilterContactsBloc>().state;
    if (state is FilterLoadedState) {
      final onlySelectedFilters = OnlySelectedFiltersService.count(state.contactsFilters);

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
