import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/tag_container.dart';
import 'package:flutter/material.dart';

class FilterViewSelectedRow extends StatelessWidget {
  final String headline;
  final List<FilterItemEntity> selectedItems;
  final Function(FilterItemEntity) onClose;

  const FilterViewSelectedRow({
    Key? key,
    required this.headline,
    required this.selectedItems,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              headline,
              style: theme.textTheme.bodyText1!.copyWith(
                color: theme.cardColor.withOpacity(0.68),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Wrap(
              children: List.generate(
                selectedItems.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(
                    right: 4,
                    bottom: 4,
                  ),
                  child: TagContainer(
                    text: selectedItems[index].name,
                    isCloseAction: true,
                    onTap: () {
                      onClose(selectedItems[index]);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
