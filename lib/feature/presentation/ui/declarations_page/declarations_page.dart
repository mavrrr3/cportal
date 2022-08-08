import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_visibility_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declarations_content_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/web/declarations_content_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_web.dart';
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
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
    _contentInit();
  }

  // Во время инициализации запускается ивент и подгружаются заявления и фильтры.
  void _contentInit() {
    BlocProvider.of<DeclarationsBloc>(context, listen: false).add(const FetchDeclarationsEvent(isFirstFetch: true));
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
            if (isLargerThenTablet(context))
              DeclarationsContentWeb(
                searchController: _searchController,
                onFilterTap: () {
                  context
                      .read<FilterVisibilityBloc>()
                      .add(const FilterChangeVisibilityEvent(isActive: true));
                },
              )
            else
              DeclarationsContentMobile(
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
            BlocBuilder<FilterVisibilityBloc, FilterVisibilityState>(
              builder: (_, state) {
                return state.isActive
                    ? GestureDetector(
                        onTap: () => context
                            .read<FilterVisibilityBloc>()
                            .add(const FilterChangeVisibilityEvent(
                              isActive: false,
                            )),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: theme.barrierColor,
                        ),
                      )
                    : const SizedBox();
              },
            ),
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
    _tabController.dispose();
  }
}
