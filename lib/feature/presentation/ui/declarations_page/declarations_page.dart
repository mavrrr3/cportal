import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/selected_filters_view.dart.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/all_declarations.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/you_hadnt_declarations_title.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeclarationsPage extends StatefulWidget {
  const DeclarationsPage({Key? key}) : super(key: key);

  @override
  State<DeclarationsPage> createState() => _DeclarationsPageState();
}

class _DeclarationsPageState extends State<DeclarationsPage> {
  late TextEditingController _searchController;
  late bool _isFilterOpenWeb;
  @override
  void initState() {
    _searchController = TextEditingController();
    _isFilterOpenWeb = false;
    _contentInit();
    super.initState();
  }

  // Во время инициализации запускается эвент и подгружаются контакты и фильтры.
  void _contentInit() {
    BlocProvider.of<ContactsBloc>(context, listen: false)
        .add(FetchContactsEvent());
    BlocProvider.of<FilterBloc>(context, listen: false)
        .add(FetchFiltersEvent());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveVisibility(
                      visible: false,
                      visibleWhen: const [
                        Condition<dynamic>.largerThan(name: MOBILE),
                      ],
                      // Меню Web.
                      child: DesktopMenu(
                        currentIndex: 4,
                        onChange: (index) => changePage(context, index),
                      ),
                    ),
                    if (state is FetchContactsLoadingState)
                      const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (state is FetchContactsLoadedState)
                      Expanded(
                        child: SafeArea(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: kIsWeb ? 12 : 11,
                                ),
                                Padding(
                                  padding: getHorizontalPadding(context),
                                  child: ResponsiveConstraints(
                                    constraint:
                                        const BoxConstraints(maxWidth: 640),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Поиск.
                                        SearchInput(
                                          controller: _searchController,
                                          onChanged: (text) {},
                                        ),

                                        // Фильтр.
                                        FilterButton(
                                          onTap: () async {
                                            if (!ResponsiveWrapper.of(context)
                                                .isLargerThan(MOBILE)) {
                                              await _showFilterMobile(theme);
                                            } else {
                                              setState(() {
                                                _isFilterOpenWeb = true;
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Выбранные фильтры.
                                Padding(
                                  padding: getHorizontalPadding(context),
                                  child: BlocBuilder<FilterBloc, FilterState>(
                                    builder: (context, state) {
                                      if (state is FilterLoadedState) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height:
                                                  _isAnyFilterSelected(state)
                                                      ? 19
                                                      : 31,
                                            ),
                                            SelectedFiltersView(
                                              state: state,
                                              onClose: (item, i) {
                                                BlocProvider.of<FilterBloc>(
                                                  context,
                                                ).add(
                                                  FilterRemoveItemEvent(
                                                    filterIndex: i,
                                                    item: item,
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height:
                                                  _isAnyFilterSelected(state)
                                                      ? 8
                                                      : 0,
                                            ),
                                          ],
                                        );
                                      }

                                      // TODO: Обработать другие стейты.
                                      return const SizedBox();
                                    },
                                  ),
                                ),

                                const WithDeclarations(),

                                // Если ещё нет заявлений
                                // const EmptyDeclarations(),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                if (_isFilterOpenWeb)
                  GestureDetector(
                    onTap: () => setState(() {
                      _isFilterOpenWeb = false;
                    }),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: getBarrierColor(theme),
                    ),
                  ),
                if (_isFilterOpenWeb)
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilterWeb(
                      onApply: _onApplyFilter,
                      onClear: _onClearFilter,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Filter Bottom Sheet Mobile.
  Future<void> _showFilterMobile(ThemeData theme) async {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.splashColor,
      barrierColor: getBarrierColor(theme),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        snap: true,
        initialChildSize: 0.57,
        minChildSize: 0.57,
        maxChildSize: 0.875,
        builder: (
          context,
          scrollController,
        ) =>
            Filter(
          scrollController: scrollController,
          onApply: _onApplyFilter,
          onClear: _onClearFilter,
        ),
      ),
    );
  }

  void _onApplyFilter() {
    if (ResponsiveWrapper.of(context).isLargerThan(TABLET)) {
      setState(() {
        _isFilterOpenWeb = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _onClearFilter() {
    BlocProvider.of<FilterBloc>(
      context,
    ).add(FilterRemoveAllEvent());
  }

  bool _isAnyFilterSelected(FilterLoadedState state) {
    bool isActive = false;
    // ignore: avoid_function_literals_in_foreach_calls
    state.filters.forEach((filter) {
      // ignore: avoid_function_literals_in_foreach_calls
      filter.items.forEach((item) {
        if (item.isActive) {
          isActive = true;
        }
      });
    });

    return isActive;
  }
}

class NewDeclarations extends StatelessWidget {
  const NewDeclarations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final halfWidth = MediaQuery.of(context).size.width / 2 - 24;

    return Column(
      children: [
        // ! Отображать если нет заявлений.
        const YouHadntDeclarationsTitle(),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DeclarationCard(
                    width: halfWidth,
                    svgPath: 'assets/icons/calendar.svg',
                    text: AppLocalizations.of(context)!.buisenesTripDeclaration,
                  ),
                  DeclarationCard(
                    width: halfWidth,
                    svgPath: 'assets/icons/fly_vocation.svg',
                    text: AppLocalizations.of(context)!.vocationDeclaration,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DeclarationCard(
                    width: halfWidth,
                    svgPath: 'assets/icons/lock.svg',
                    text: AppLocalizations.of(context)!.passDeclaration,
                  ),
                  DeclarationCard(
                    width: halfWidth,
                    svgPath: 'assets/icons/pay_list.svg',
                    text: AppLocalizations.of(context)!.payListDeclaration,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DeclarationCard(
                width: double.infinity,
                svgPath: 'assets/icons/support.svg',
                text: AppLocalizations.of(context)!.supportDeclaration,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WithDeclarations extends StatefulWidget {
  const WithDeclarations({Key? key}) : super(key: key);

  @override
  State<WithDeclarations> createState() => _WithDeclarationsState();
}

class _WithDeclarationsState extends State<WithDeclarations>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TabBar(
                      labelStyle: theme.textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      labelColor: theme.primaryColor,
                      unselectedLabelColor: theme.cardColor,
                      indicatorColor: theme.primaryColor,
                      controller: tabController,
                      tabs: const [
                        Tab(
                          child: Text('Заявления'),
                        ),
                        Tab(
                          child: Text('Новые'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: theme.dividerColor,
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: const [
                Padding(
                  padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                  child: AllDeclarations(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: NewDeclarations(),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
