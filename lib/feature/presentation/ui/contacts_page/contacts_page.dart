import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/contact_profile_pop_up.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/favorites_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/favorites_wrap.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/selected_filters_view.dart.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_input.dart';
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
                    if (state is ContactsLoadingState)
                      const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (state is ContactsLoadedState)
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

                                // Избранные.
                                if (state.data.favorites.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: getSingleHorizontalPadding(context),
                                      bottom: 16,
                                    ),
                                    child: !ResponsiveWrapper.of(context)
                                            .isLargerThan(TABLET)
                                        ? SizedBox(
                                            height: 48,
                                            child: FavoritesRow(
                                              items: state.data.favorites,
                                              onTap: (i) {
                                                _goToUserPage(state, i);
                                              },
                                            ),
                                          )
                                        : FavoritesWrap(
                                            items: state.data.favorites,
                                            onTap: (i) async {
                                              if (ResponsiveWrapper.of(
                                                context,
                                              ).isDesktop) {
                                                await _showContactProfile(
                                                  state,
                                                  i,
                                                );
                                              } else {
                                                _goToUserPage(state, i);
                                              }
                                            },
                                          ),
                                  ),

                                // Колонка контактов.
                                Padding(
                                  padding: getHorizontalPadding(context),
                                  child: !kIsWeb
                                      ? ContactsList(
                                          items: state.data.contacts,
                                          onTap: (i) => _goToUserPage(state, i),
                                        )
                                      : Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: List.generate(
                                            state.data.contacts.length,
                                            (i) => GestureDetector(
                                              behavior:
                                                  HitTestBehavior.translucent,
                                              onTap: () async {
                                                if (ResponsiveWrapper.of(
                                                  context,
                                                ).isDesktop) {
                                                  await _showContactProfile(
                                                    state,
                                                    i,
                                                  );
                                                } else {
                                                  _goToUserPage(state, i);
                                                }
                                              },
                                              child: ContactCard(
                                                item: state.data.contacts[i],
                                                width: ResponsiveWrapper.of(
                                                  context,
                                                ).isLargerThan(MOBILE)
                                                    ? 328
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),

                                const SizedBox(height: 42),
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

  void _goToUserPage(
    ContactsLoadedState state,
    int i,
  ) =>
      GoRouter.of(context).pushNamed(
        NavigationRouteNames.contactProfile,
        params: {'fid': state.data.contacts[i].id},
      );

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

  Future<void> _showContactProfile(
    ContactsLoadedState state,
    int i,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        final ThemeData theme = Theme.of(context);

        return StatefulBuilder(
          builder: (context, setState) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  color: theme.splashColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: ContactProfilePopUp(user: state.data.contacts[i]),
                ),
              ),
            );
          },
        );
      },
    );
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
