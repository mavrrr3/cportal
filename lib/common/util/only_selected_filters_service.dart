import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';

class OnlySelectedFiltersService {
  static List<FilterEntity> count(List<FilterEntity> filters) {
    final List<FilterEntity> onlySelected = [];
    for (final filter in filters) {
      final List<FilterItemEntity> selectedItems = [];
      for (final item in filter.items) {
        if (item.isActive) {
          selectedItems.add(item);
        }
      }
      if (selectedItems.isNotEmpty) {
        onlySelected.add(FilterEntity(headline: filter.headline, items: selectedItems));
      }
    }

    return onlySelected;
  }
}
