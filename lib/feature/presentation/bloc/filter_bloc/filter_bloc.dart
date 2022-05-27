import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/mocks/mocks.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/filter_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final FetchFiltersUseCase fetchFilters;

  FilterBloc({required this.fetchFilters}) : super(FilterEmptyState()) {
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

  // Получение данных от API.
  FutureOr<void> _onFetch(
    FetchFiltersEvent event,
    Emitter emit,
  ) async {
    emit(FilterLoadingState());

    String _mapFailureToMessage(Failure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return 'Ошибка на сервере';
        case CacheFailure:
          return 'Ошибка обработки кэша';
        default:
          return 'Unexpected Error';
      }
    }

    final failureOrFilters = await fetchFilters();

    failureOrFilters.fold(
      (failure) {
        emit(FilterLoadingErrorState(
          message: _mapFailureToMessage(failure),
        ));
      },
      (filters) {
        // log('||| ${filters} ***');
        // emit(FilterLoadedState(filters: filters));
        emit(FilterLoadedState(filters: Mocks.filter));
      },
    );

    debugPrint('Отработал эвент: $event');
  }

  // Обработка раскрытия раздела в фильтре.
  FutureOr<void> _onExpandSection(
    FilterExpandSectionEvent event,
    Emitter emit,
  ) async {
    final List<FilterEntity> filters = (state as FilterLoadedState).filters;
    FilterEntity filter = filters[event.index];
    filter = filter.copyWith(isActive: filter.changeActivity);

    // log('*** ${_filters[event.index]} ***');
    // log('=== ${_filter}');

    filters[event.index] = filter;

    emit(FilterLoadingState());
    emit(FilterLoadedState(filters: filters));

    debugPrint('Отработал эвент: $event');
  }

  // Обработка выбора пункта в фильтре.
  FutureOr<void> _onSelect(
    FilterSelectItemEvent event,
    Emitter emit,
  ) {
    final List<FilterEntity> filters = (state as FilterLoadedState).filters;
    final FilterEntity filter = filters[event.filterIndex];
    final FilterItemEntity filterItem =
        filters[event.filterIndex].items[event.itemIndex];

    final List<FilterItemEntity> itemsWithSelect =
        selectItems(filter, filterItem);
    final FilterEntity filterWithSelect =
        filter.copyWith(items: itemsWithSelect);
    filters[event.filterIndex] = filterWithSelect;

    emit(FilterLoadingState());
    emit(FilterLoadedState(filters: filters));
  }

  FutureOr<void> _onRemove(
    FilterRemoveItemEvent event,
    Emitter emit,
  ) async {
    final List<FilterEntity> filters = (state as FilterLoadedState).filters;

    final int itemIndex = filters[event.filterIndex].items.indexOf(event.item);
    final FilterEntity filter = filters[event.filterIndex];
    final FilterItemEntity filterItem =
        filters[event.filterIndex].items[itemIndex];

    final List<FilterItemEntity> itemsWithSelect =
        selectItems(filter, filterItem);
    final FilterEntity filterWithSelect =
        filter.copyWith(items: itemsWithSelect);
    filters[event.filterIndex] = filterWithSelect;

    emit(FilterLoadingState());
    emit(FilterLoadedState(filters: filters));

    debugPrint('Отработал эвент: $event');
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
