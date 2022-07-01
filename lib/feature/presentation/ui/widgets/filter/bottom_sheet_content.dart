import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_action_buttons.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_section.dart';
import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  final ScrollController scrollController;
  final List<FilterEntity> filters;
  final Function(int) onExpand;
  final Function(int, int) onSelect;
  final Function() onApply;
  final Function() onClear;

  const BottomSheetContent({
    Key? key,
    required this.scrollController,
    required this.filters,
    required this.onExpand,
    required this.onSelect,
    required this.onApply,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Контент фильтра.
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: filters.length,
              itemBuilder: (context, index) => FilterSection(
                item: filters[index],
                onExpand: () => onExpand(index),
                onSelect: (i) => onSelect(index, i),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Кнопки фильтра.
          FilterActionButtons(
            width: (MediaQuery.of(context).size.width - 44) / 2,
            onApply: onApply,
            onClear: onClear,
          ),
        ],
      ),
    );
  }
}
