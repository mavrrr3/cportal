import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_action_buttons.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_section.dart';
import 'package:flutter/material.dart';

class FilterWebContent extends StatelessWidget {
  final List<FilterEntity> filters;
  final List<TextEditingController> controllers;
  final Function() onApply;
  final Function() onClear;
  final Function(int) onExpand;
  final Function(int, int) onSelect;
  final Function(int, String) onSearch;

  const FilterWebContent({
    Key? key,
    required this.filters,
    required this.controllers,
    required this.onApply,
    required this.onClear,
    required this.onExpand,
    required this.onSearch,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final double width = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: MediaQuery.of(context).size.height,
      width: width * 0.25,
      decoration: BoxDecoration(color: theme.cardColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filters.length,
                itemBuilder: (context, index) => FilterSection(
                  sectionWidth: width * 0.25 - 80,
                  item: filters[index],
                  controller: TextEditingController(),
                  onExpand: () => onExpand(index),
                  onSelect: (i) => onSelect(index, i),
                  onSearch: (text) => onSearch(index, text),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: FilterActionButtons(
                width: (width * 0.25 - 48) / 2,
                onApply: onApply,
                onClear: onClear,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
