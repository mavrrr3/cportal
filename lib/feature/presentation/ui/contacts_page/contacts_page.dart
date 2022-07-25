import 'dart:async';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/only_selected_filters_service.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/contact_profile_pop_up.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list/contacts_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/selected_filters_view.dart.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
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
  late bool _isFilterOpenWeb;
  @override
  void initState() {
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    _isFilterOpenWeb = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    _setupScrollController(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: theme.background,
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
                Expanded(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: kIsWeb ? 12 : 11,
                        ),
                        // Поиск.
                        SearchWithFilter(
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
                              setState(() {
                                _isFilterOpenWeb = true;
                              });
                            }
                          },
                        ),

                        // Выбранные фильтры.
                        BlocBuilder<FilterContactsBloc, FilterState>(
                          builder: (context, state) {
                            if (state is FilterLoadedState) {
                              return SelectedFiltersView(
                                filters: state.contactsFilters,
                                onRemove: (item, i) async {
                                  BlocProvider.of<FilterContactsBloc>(
                                    context,
                                  ).add(
                                    FilterRemoveItemEvent(
                                      filterIndex: i,
                                      item: item,
                                    ),
                                  );
                                  await Future<dynamic>.delayed(const Duration(milliseconds: 150));
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

                            return Expanded(
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                        await _goToUserPage(
                                          contacts,
                                          i,
                                        );
                                      },
                                    ),

                                    const SizedBox(height: 42),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_isFilterOpenWeb)
              GestureDetector(
                onTap: _onApplyFilter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: theme.barrierColor,
                ),
              ),
            if (_isFilterOpenWeb)
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
      setState(() {
        _isFilterOpenWeb = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  // Кнопка [Очистить] фильтр.
  void _onClearFilter() {
    BlocProvider.of<FilterContactsBloc>(
      context,
    ).add(FilterRemoveAllEvent());
    BlocProvider.of<ContactsBloc>(
      context,
      listen: false,
    ).add(
      const FetchContactsEvent(isFirstFetch: true),
    );
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
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
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
    final state = BlocProvider.of<FilterContactsBloc>(
      context,
    ).state;

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
    final state = BlocProvider.of<FilterContactsBloc>(
      context,
    ).state;
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
