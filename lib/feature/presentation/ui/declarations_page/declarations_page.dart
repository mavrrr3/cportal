import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/selected_filters_view.dart.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/all_declarations.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/you_hadnt_declarations_title.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/desktop_menu.dart';
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

class _DeclarationsPageState extends State<DeclarationsPage>  with SingleTickerProviderStateMixin{
  late TextEditingController _searchController;
    late TabController _tabController;
  late bool _isFilterOpenWeb;
  @override
  void initState() {
    _searchController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
   
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
                      Expanded(
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                const SizedBox(
                                  height: kIsWeb ? 12 : 11,
                                ),
                                SearchWithFilter(
                                  searchController: _searchController,
                                  onSearch: (text) {},
                                  onFilterTap: () async {
                                    if (!ResponsiveWrapper.of(context)
                                        .isLargerThan(MOBILE)) {
                                      await showFilterMobile(
                                        context,
                                        theme,
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

                               SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TabBar(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  labelStyle: theme.textTheme.px22.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  labelColor: theme.primary,
                  unselectedLabelColor: theme.cardColor,
                  indicatorColor: theme.primary,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        'Заявления',
                        style: theme.textTheme.px16
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Новые',
                        style: theme.textTheme.px16
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: theme.divider,
            ),
                          
                               WithDeclarations(tabController: _tabController,),
                          
                              // Если ещё нет заявлений
                              // const EmptyDeclarations(),
                            ],
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

class WithDeclarations extends StatelessWidget {
  final TabController tabController;

  const WithDeclarations({Key? key, required this.tabController,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
             
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
      ),
    );
  }
}
