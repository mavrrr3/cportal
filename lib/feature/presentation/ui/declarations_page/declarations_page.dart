import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_declarations_bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declarations_content_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/web/declarations_content_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DeclarationsPage extends StatefulWidget {
  const DeclarationsPage({Key? key}) : super(key: key);

  @override
  State<DeclarationsPage> createState() => _DeclarationsPageState();
}

class _DeclarationsPageState extends State<DeclarationsPage> with SingleTickerProviderStateMixin {
  late bool _isFilterOpenWeb;
  late TextEditingController _searchController;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _isFilterOpenWeb = false;
    _searchController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
    _contentInit();
  }

  // Во время инициализации запускается ивент и подгружаются заявления и фильтры.
  void _contentInit() {
    BlocProvider.of<DeclarationsBloc>(context, listen: false).add(const FetchDeclarationsEvent());
    BlocProvider.of<FilterDeclarationsBloc>(context, listen: false).add(FetchFiltersEvent());
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

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
                    currentIndex: 3,
                    onChange: (index) => changePage(context, index),
                  ),
                ),
                // ignore: prefer_if_elements_to_conditional_expressions
                isLargerThenTablet(context)
                    ? DeclarationsContentWeb(
                        searchController: _searchController,
                        onFilterTap: () {
                          setState(() {
                            _isFilterOpenWeb = true;
                          });
                        },
                      )
                    : DeclarationsContentMobile(
                        searchController: _searchController,
                        tabController: _tabController,
                        onFilterTap: () async {
                          await showFilterMobile(
                            context,
                            onApply: _onApplyFilter,
                            onClear: _onClearFilter,
                            type: FilterType.declarations,
                          );
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
                  type: FilterType.declarations,
                  onApply: _onApplyFilter,
                  onClear: _onClearFilter,
                ),
              ),
          ],
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
    BlocProvider.of<FilterDeclarationsBloc>(
      context,
    ).add(FilterRemoveAllEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _tabController.dispose();
  }
}
