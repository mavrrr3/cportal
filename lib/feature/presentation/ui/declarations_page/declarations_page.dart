import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_visibility_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declarations_content_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/web/declarations_content_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DeclarationsPage extends StatefulWidget {
  const DeclarationsPage({Key? key}) : super(key: key);

  @override
  State<DeclarationsPage> createState() => _DeclarationsPageState();
}

class _DeclarationsPageState extends State<DeclarationsPage>
    with SingleTickerProviderStateMixin {
  late TextEditingController _searchController;
  late FocusNode _searchFocus;

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocus = FocusNode();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: theme.background,
        body: isLargerThenTablet(context)
            ? DeclarationsContentWeb(
                searchController: _searchController,
                searchFocus: _searchFocus,
                onFilterTap: () {
                  context
                      .read<FilterVisibilityBloc>()
                      .add(const FilterChangeVisibilityEvent(isActive: true));
                },
              )
            : DeclarationsContentMobile(
                searchController: _searchController,
                searchFocus: _searchFocus,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(NavigationRouteNames.createDeclaration);
          },
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
      ),
    );
  }

  void _onApplyFilter() {
    if (ResponsiveWrapper.of(context).isLargerThan(TABLET)) {
      context
          .read<FilterVisibilityBloc>()
          .add(const FilterChangeVisibilityEvent(isActive: false));
    } else {
      Navigator.pop(context);
    }
  }

  void _onClearFilter() {
    context.read<FilterDeclarationsBloc>().add(FilterRemoveAllEvent());
    context
        .read<FilterVisibilityBloc>()
        .add(const FilterChangeVisibilityEvent(isActive: false));
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _searchFocus.dispose();
    _tabController.dispose();
  }
}
