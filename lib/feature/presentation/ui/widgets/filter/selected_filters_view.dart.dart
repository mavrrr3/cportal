import 'package:flutter/material.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_view_row.dart';

class SelectedFiltersView extends StatelessWidget {
  final List<FilterEntity> filters;
  final Function(FilterItemEntity, int) onRemove;

  /// Рендеринг всех выбранных фильтров.
  const SelectedFiltersView({
    Key? key,
    required this.filters,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getHorizontalPadding(context),
      child: Column(
        children: [
          SizedBox(
            height: _isAnyFilterSelected(filters) ? 19 : 31,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: filters.length,
            itemBuilder: (context, index) {
              // Выбран ли хоть один пункт в текущем разделе фильтра.
              final bool isActive = filters[index].items.any((element) => element.isActive);

              // Если isActive - создаем список только с выбранными пунктами в текущем разделе.
              final List<FilterItemEntity> selectedItems = [];
              if (isActive) {
                for (final item in filters[index].items) {
                  if (item.isActive) {
                    selectedItems.add(item);
                  }
                }
              }

              return isActive
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: FilterViewRow(
                        headline: filters[index].headline,
                        selectedItems: selectedItems,
                        onClose: onRemove,
                      ),
                    )
                  : const SizedBox();
            },
          ),
          SizedBox(
            height: _isAnyFilterSelected(filters) ? 8 : 0,
          ),
        ],
      ),
    );
  }

  bool _isAnyFilterSelected(List<FilterEntity> filters) {
    bool isActive = false;
    // ignore: avoid_function_literals_in_foreach_calls
    filters.forEach((filter) {
      // ignore: avoid_function_literals_in_foreach_calls
      filter.items.forEach((item) {
        if (item.isActive) {
          isActive = true;
        }
      });
    });

    return isActive;
  }
}
