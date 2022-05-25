import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/feature/data/mocks/mocks.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FetchFiltersEvent>(
      _onFetch,
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

  // Получение данных от API
  FutureOr<void> _onFetch(
    FetchFiltersEvent event,
    Emitter emit,
  ) async {
    emit(FilterLoadingState());

    //TODO реализовать получение данных от API

    emit(FilterLoadedState(filters: Mocks.filter));

    debugPrint('Отработал эвент: ' + event.toString());
  }

  // Обработка раскрытия раздела в фильтре
  FutureOr<void> _onExpandSection(
    FilterExpandSectionEvent event,
    Emitter emit,
  ) async {
    List<FilterEntity> _filters = (state as FilterLoadedState).filters;
    FilterEntity _filter = _filters[event.index];
    _filter = _filter.copyWith(isActive: _filter.changeActivity);
    _filters[event.index] = _filter;

    emit(FilterLoadingState());
    emit(FilterLoadedState(filters: _filters));

    debugPrint('Отработал эвент: ' + event.toString());
  }

  // Обработка выбора пункта в фильтре
  FutureOr<void> _onSelect(
    FilterSelectItemEvent event,
    Emitter emit,
  ) {
    List<FilterEntity> _filters = (state as FilterLoadedState).filters;
    _filters[event.filterIndex].items[event.itemIndex].isActive =
        !_filters[event.filterIndex].items[event.itemIndex].isActive;

    emit(FilterLoadingState());
    emit(FilterLoadedState(filters: _filters));
  }

  FutureOr<void> _onRemove(
    FilterRemoveItemEvent event,
    Emitter emit,
  ) async {
    List<FilterEntity> _filters = (state as FilterLoadedState).filters;

    final int itemIndex = _filters[event.filterIndex].items.indexOf(event.item);
    _filters[event.filterIndex].items[itemIndex].isActive =
        !_filters[event.filterIndex].items[itemIndex].isActive;

    emit(FilterLoadingState());
    emit(FilterLoadedState(filters: _filters));

    debugPrint('Отработал эвент: ' + event.toString());
  }
}
