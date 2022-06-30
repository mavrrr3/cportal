import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';

// Обработка раскрытия раздела в фильтре.
List<FilterEntity> filterExpandSection({
  required List<FilterEntity> filters,
  required int index,
}) {
  FilterEntity filter = filters[index];
  filter = filter.copyWith(isActive: filter.changeActivity);
  filters[index] = _switchFilterEntityToFilterModel(filter);

  return filters;
}

// Обработка выбора пункта в фильтре.
List<FilterEntity> filterSelect({
  required List<FilterEntity> filters,
  required int filterIndex,
  required int itemIndex,
}) {
  final FilterEntity filter = filters[filterIndex];
  final FilterItemEntity filterItem = filters[filterIndex].items[itemIndex];

  final List<FilterItemEntity> itemsWithSelect =
      _selectItems(filter, filterItem);
  final FilterEntity filterWithSelect = filter.copyWith(items: itemsWithSelect);
  filters[filterIndex] = _switchFilterEntityToFilterModel(filterWithSelect);

  return filters;
}

// Обработка удаления пункта фильтра из вью выбранных.
List<FilterEntity> filterRemove({
  required List<FilterEntity> filters,
  required int filterIndex,
  required FilterItemEntity item,
}) {
  final int itemIndex = filters[filterIndex].items.indexOf(item);
  final FilterEntity filter = filters[filterIndex];
  final FilterItemEntity filterItem = filters[filterIndex].items[itemIndex];

  final List<FilterItemEntity> itemsWithSelect =
      _selectItems(filter, filterItem);
  final FilterEntity filterWithSelect = filter.copyWith(items: itemsWithSelect);
  filters[filterIndex] = _switchFilterEntityToFilterModel(filterWithSelect);

  return filters;
}

// Делает все выбранные пункты из стейта неактивными.
List<FilterEntity> filterRemoveAll({
  required List<FilterEntity> filters,
}) {
  // ignore: prefer-correct-identifier-length
  for (int i = 0; i < filters.length; i++) {
    if (filters[i].isActive) {
      FilterEntity filter = filters[i];
      filter = filter.copyWith(isActive: filter.changeActivity);

      filters[i] = _switchFilterEntityToFilterModel(filter);
    }

    for (int itemIndex = 0; itemIndex < filters[i].items.length; itemIndex++) {
      final FilterEntity filter = filters[i];

      final List<FilterItemEntity> unselectedItems = _unselectItems(filter);
      final FilterEntity filterWithoutSelect =
          filter.copyWith(items: unselectedItems);
      filters[i] = _switchFilterEntityToFilterModel(filterWithoutSelect);
    }
  }

  return filters;
}

//-- Вспомогательные функции
//
FilterModel _switchFilterEntityToFilterModel(FilterEntity filterEntity) {
  return FilterModel(
    headline: filterEntity.headline,
    items: _switchFilterItemsEntityToFilterItemsModel(filterEntity.items),
    isActive: filterEntity.isActive,
  );
}

List<FilterItemModel> _switchFilterItemsEntityToFilterItemsModel(
  List<FilterItemEntity> itemsEntityList,
) {
  final List<FilterItemModel> itemsModel = [];
  for (final FilterItemEntity item in itemsEntityList) {
    itemsModel.add(FilterItemModel(
      name: item.name,
      isActive: item.isActive,
    ));
  }

  return itemsModel;
}

List<FilterItemEntity> _selectItems(
  FilterEntity entity,
  FilterItemEntity filterItem,
) {
  return entity.items.map((item) {
    if (item.name == filterItem.name) {
      return item.copyWith(isActive: item.changeActivity);
    }

    return item;
  }).toList();
}

List<FilterItemEntity> _unselectItems(
  FilterEntity entity,
) {
  return entity.items.map((item) {
    if (item.isActive) {
      return item.copyWith(isActive: item.changeActivity);
    }

    return item;
  }).toList();
}
//
