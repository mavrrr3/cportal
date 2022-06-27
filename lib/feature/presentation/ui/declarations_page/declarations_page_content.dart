import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_contacts_bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declarations_tab_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declarations_tabs_content.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/selected_filters_view.dart.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeclarationsPageContent extends StatefulWidget {
  final Function() onFilterTap;

  const DeclarationsPageContent({
    Key? key,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  State<DeclarationsPageContent> createState() => _DeclarationsPageContentState();
}

class _DeclarationsPageContentState extends State<DeclarationsPageContent> with SingleTickerProviderStateMixin {
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
                BlocProvider.of<FilterContactsBloc>(
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
