import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/open_filter_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/burger_menu_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return ResponsiveConstraints(
      constraint: const BoxConstraints(maxWidth: 640),
      child: Row(
        children: [
          BurgerMenuButton(
            onTap: () {
              context.read<NavigationBarBloc>().add(
                    const NavBarVisibilityEvent(
                      isActive: true,
                    ),
                  );
            },
          ),

          // Поиск.
          Expanded(
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
        ],
      ),
    );
  }
}
