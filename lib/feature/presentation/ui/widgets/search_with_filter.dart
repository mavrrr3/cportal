import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/open_filter_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SearchWithFilter extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final Function() onFilterTap;

  const SearchWithFilter({
    Key? key,
    required this.searchController,
    required this.onSearch,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getHorizontalPadding(context),
      child: ResponsiveConstraints(
        constraint: const BoxConstraints(maxWidth: 640),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Поиск.
            SearchInput(
              controller: searchController,
              onChanged: (text) async {
                onSearch(text);
              },
            ),

            // Фильтр.
            OpenFilterButton(
              onTap: onFilterTap,
            ),
          ],
        ),
      ),
    );
  }
}
