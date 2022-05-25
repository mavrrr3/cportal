import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/feature/data/mocks/mocks.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBloc extends Bloc<FilterEvent, FilterStateImpl> {
  FilterBloc() : super(const FilterStateImpl()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FilterInitEvent>(
      _onInit,
      transformer: bloc_concurrency.sequential(),
    );
    on<FilterExpandSectionEvent>(
      _onExpandSection,
      transformer: bloc_concurrency.sequential(),
    );
    on<FilterSelectItemEvent>(
      _onSelect,
      transformer: bloc_concurrency.sequential(),
    );
    on<FilterRemoveItemEvent>(
      _onRemove,
      transformer: bloc_concurrency.sequential(),
    );
  }

  // Инициализация фильтра
  FutureOr<void> _onInit(
    FilterInitEvent event,
    Emitter emit,
  ) async {
    //: TODO запрос получения фильтров

    emit(FilterStateImpl(filters: Mocks.filter));

    debugPrint('Отработал эвент: ' + event.toString());
  }

  // Обработка раскрытия раздела в фильтре
  void _onExpandSection(
    FilterExpandSectionEvent event,
    Emitter emit,
  ) {
    List<FilterEntity> _filters = state.filters ?? [];
    FilterEntity _filter = _filters[event.index];
    _filter = _filter.copyWith(isActive: _filter.changeActivity);
    _filters[event.index] = _filter;

    emit(FilterStateImpl(filters: _filters));

    debugPrint('Отработал эвент: ' + event.toString());
  }

  // Обработка выбора пункта в фильтре
  void _onSelect(
    FilterSelectItemEvent event,
    Emitter emit,
  ) {
    List<FilterEntity> _filters = state.filters ?? [];
    FilterEntity _filter = _filters[event.filterIndex];
    FilterItemEntity _filterItem =
        _filters[event.filterIndex].items[event.itemIndex];

    List<FilterItemEntity> itemsWithSelect = selectItems(_filter, _filterItem);
    FilterEntity filterWithSelect = _filter.copyWith(items: itemsWithSelect);
    _filters[event.filterIndex] = filterWithSelect;

    log(filterWithSelect.toString());
    emit(FilterStateImpl(filters: _filters));
  }

  // Обработка отмены выбора пункта в фильтре
  void _onRemove(
    FilterRemoveItemEvent event,
    Emitter emit,
  ) {
    List<FilterEntity> _filters = state.filters ?? [];

    final int itemIndex = _filters[event.filterIndex].items.indexOf(event.item);
    FilterEntity _filter = _filters[event.filterIndex];
    FilterItemEntity _filterItem = _filters[event.filterIndex].items[itemIndex];

    List<FilterItemEntity> itemsWithSelect = selectItems(_filter, _filterItem);
    FilterEntity filterWithSelect = _filter.copyWith(items: itemsWithSelect);
    _filters[event.filterIndex] = filterWithSelect;

    emit(FilterStateImpl(filters: _filters));

    debugPrint('Отработал эвент: ' + event.toString());
  }

  List<FilterItemEntity> selectItems(
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
}
