import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/tag_container.dart';
import 'package:flutter/material.dart';

class FilterViewRow extends StatelessWidget {
  final String headline;
  final List<FilterItemEntity> selectedItems;
  final Function(FilterItemEntity) onClose;

  /// Выбранная категория фильтра.
  const FilterViewRow({
    Key? key,
    required this.headline,
    required this.selectedItems,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            headline,
            style: theme.textTheme.px12.copyWith(
              color: theme.textLight,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: List.generate(
              selectedItems.length,
              (index) => TagContainer(
                text: selectedItems[index].name,
                isCloseAction: true,
                onTap: () {
                  onClose(selectedItems[index]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
