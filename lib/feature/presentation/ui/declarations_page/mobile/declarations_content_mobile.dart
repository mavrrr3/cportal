import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declarations_tab_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declarations_tabs_content.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/selected_filters_view.dart.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeclarationsContentMobile extends StatelessWidget {
  final TextEditingController searchController;
  final TabController tabController;
  final Function() onFilterTap;

  const DeclarationsContentMobile({
    Key? key,
    required this.searchController,
    required this.tabController,
    required this.onFilterTap,
  }) : super(key: key);

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
              searchController: searchController,
              onSearch: (text) {},
              onFilterTap: onFilterTap,
            ),

            // Выбранные фильтры.
            BlocBuilder<FilterDeclarationsBloc, FilterState>(
              builder: (context, state) {
                if (state is FilterLoadedState) {
                  return SelectedFiltersView(
                    filters: state.declarationsFilters,
                    onRemove: (item, i) {
                      BlocProvider.of<FilterDeclarationsBloc>(
                        context,
                      ).add(
                        FilterRemoveItemEvent(
                          filterIndex: i,
                          item: item,
                        ),
                      );
                    },
                  );
                }

                // TODO: отработать другие стейты.
                return const SizedBox();
              },
            ),

            // Заголовки вкладок.
            DeclarationsTabBar(
              tabController: tabController,
            ),

            // Контент вкладок.
            Expanded(
              child: DeclarationsTabsContent(
                tabController: tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
