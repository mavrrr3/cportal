import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declarations_tab_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declarations_tabs_content.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/selected_filters_view.dart.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DeclarationsPage extends StatefulWidget {
  const DeclarationsPage({Key? key}) : super(key: key);

  @override
  State<DeclarationsPage> createState() => _DeclarationsPageState();
}

class _DeclarationsPageState extends State<DeclarationsPage> {
  late bool _isFilterOpenWeb;

  @override
  void initState() {
    _isFilterOpenWeb = false;
    _contentInit();
    super.initState();
  }

  // Во время инициализации запускается эвент и подгружаются контакты и фильтры.
  void _contentInit() {
    BlocProvider.of<ContactsBloc>(context, listen: false)
        .add(const FetchContactsEvent());
    BlocProvider.of<FilterBloc>(context, listen: false)
        .add(FetchFiltersEvent());
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
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
                    if (state is ContactsLoadingState)
                      const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (state is ContactsLoadedState)
                      _DeclarationsPageContent(
                        onFilterTap: () async {
                          if (!ResponsiveWrapper.of(context)
                              .isLargerThan(MOBILE)) {
                            await showFilterMobile(
                              context,
                              onApply: _onApplyFilter,
                              onClear: _onClearFilter,
                            );
                          } else {
                            setState(() {
                              _isFilterOpenWeb = true;
                            });
                          }
                        },
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
                      color: theme.barrierColor,
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
}

class _DeclarationsPageContent extends StatefulWidget {
  final Function() onFilterTap;

  const _DeclarationsPageContent({
    Key? key,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  State<_DeclarationsPageContent> createState() =>
      _DeclarationsPageContentState();
}

class _DeclarationsPageContentState extends State<_DeclarationsPageContent>
    with SingleTickerProviderStateMixin {
  late TextEditingController _searchController;
  late TabController _tabController;

  @override
  void initState() {
    _searchController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kIsWeb ? 12 : 11,
            ),

            // Строка с поиском.
            SearchWithFilter(
              searchController: _searchController,
              onSearch: (text) {},
              onFilterTap: widget.onFilterTap,
            ),

            // Выбранные фильтры.
            SelectedFiltersView(
              onRemove: (item, i) {
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

            // Заголовки вкладок.
            DeclarationsTabBar(
              tabController: _tabController,
            ),

            // Контент вкладок.
            DeclarationsTabsContent(
              tabController: _tabController,
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
    _tabController.dispose();
  }
}
