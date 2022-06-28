// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_declarations_filters_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDeclarationsBloc extends Bloc<FilterEvent, FilterState> {
  final FetchDeclarationsFiltersUseCase fetchFilters;

  FilterDeclarationsBloc({required this.fetchFilters})
      : super(FilterEmptyState()) {
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
    on<FilterRemoveAllEvent>(
      _onRemoveAll,
      transformer: bloc_concurrency.sequential(),
    );
  }

  // Получение данных от API.
  FutureOr<void> _onFetch(
    FetchFiltersEvent event,
    Emitter emit,
  ) async {
    final oldState = state;
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

    final failureOrFilters = await fetchFilters(
      FetchFiltersParams(),
    );

    failureOrFilters.fold(
      (failure) {
        emit(FilterLoadingErrorState(
          message: _mapFailureToMessage(failure),
        ));
      },
      (response) {
        final List<FilterEntity> filters = [];
        // ignore: unnecessary_lambdas
        response.filters.forEach((element) {
          filters.add(element);
        });

        FilterLoadedState? newState;
        if (oldState is FilterLoadedState) {
          newState = oldState.copyWith(declarationsFilters: filters);
        }

        emit(newState ?? FilterLoadedState(declarationsFilters: filters));
      },
    );

    debugPrint('Отработал эвент: $event');
  }

  // Обработка раскрытия раздела в фильтре.
  FutureOr<void> _onExpandSection(
    FilterExpandSectionEvent event,
    Emitter emit,
  ) async {
    if (state is FilterLoadedState) {
      final List<FilterEntity> filters =
          (state as FilterLoadedState).declarationsFilters;
      FilterEntity filter = filters[event.index];
      filter = filter.copyWith(isActive: filter.changeActivity);

      filters[event.index] = switchFilterEntityToFilterModel(filter);
      final newState =
          (state as FilterLoadedState).copyWith(declarationsFilters: filters);

      emit(FilterLoadingState());
      emit(newState);
    }
  }

  // Обработка выбора пункта в фильтре.
  FutureOr<void> _onSelect(
    FilterSelectItemEvent event,
    Emitter emit,
  ) {
    if (state is FilterLoadedState) {
      final List<FilterEntity> filters =
          (state as FilterLoadedState).declarationsFilters;
      final FilterEntity filter = filters[event.filterIndex];
      final FilterItemEntity filterItem =
          filters[event.filterIndex].items[event.itemIndex];

      final List<FilterItemEntity> itemsWithSelect =
          selectItems(filter, filterItem);
      final FilterEntity filterWithSelect =
          filter.copyWith(items: itemsWithSelect);
      filters[event.filterIndex] =
          switchFilterEntityToFilterModel(filterWithSelect);
      final newState =
          (state as FilterLoadedState).copyWith(declarationsFilters: filters);

      emit(FilterLoadingState());
      emit(newState);
    }
  }

  // Обработка удаления пункта фильтра из вью выбранных.
  FutureOr<void> _onRemove(
    FilterRemoveItemEvent event,
    Emitter emit,
  ) async {
    if (state is FilterLoadedState) {
      final List<FilterEntity> filters =
          (state as FilterLoadedState).declarationsFilters;

      final int itemIndex =
          filters[event.filterIndex].items.indexOf(event.item);
      final FilterEntity filter = filters[event.filterIndex];
      final FilterItemEntity filterItem =
          filters[event.filterIndex].items[itemIndex];

      final List<FilterItemEntity> itemsWithSelect =
          selectItems(filter, filterItem);
      final FilterEntity filterWithSelect =
          filter.copyWith(items: itemsWithSelect);
      filters[event.filterIndex] =
          switchFilterEntityToFilterModel(filterWithSelect);
      final newState =
          (state as FilterLoadedState).copyWith(declarationsFilters: filters);

      emit(FilterLoadingState());
      emit(newState);
    }
  }

  // Делает все выбранные пункты из стейта неактивными.
  FutureOr<void> _onRemoveAll(
    FilterRemoveAllEvent event,
    Emitter emit,
  ) async {
    if (state is FilterLoadedState) {
      final List<FilterEntity> filters =
          (state as FilterLoadedState).declarationsFilters;

      // ignore: prefer-correct-identifier-length
      for (int i = 0; i < filters.length; i++) {
        if (filters[i].isActive) {
          FilterEntity filter = filters[i];
          filter = filter.copyWith(isActive: filter.changeActivity);

          filters[i] = switchFilterEntityToFilterModel(filter);
        }

        for (int itemIndex = 0;
            itemIndex < filters[i].items.length;
            itemIndex++) {
          final FilterEntity filter = filters[i];

          final List<FilterItemEntity> unselectedItems = unselectItems(filter);
          final FilterEntity filterWithoutSelect =
              filter.copyWith(items: unselectedItems);
          filters[i] = switchFilterEntityToFilterModel(filterWithoutSelect);
        }
      }
      final newState =
          (state as FilterLoadedState).copyWith(declarationsFilters: filters);

      emit(FilterLoadingState());
      emit(newState);

      debugPrint('Отработал эвент: $event');
    }
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

  List<FilterItemEntity> unselectItems(
    FilterEntity entity,
  ) {
    return entity.items.map((item) {
      if (item.isActive) {
        return item.copyWith(isActive: item.changeActivity);
      }

      return item;
    }).toList();
  }

  FilterModel switchFilterEntityToFilterModel(FilterEntity filterEntity) {
    return FilterModel(
      headline: filterEntity.headline,
      items: switchFilterItemsEntityToFilterItemsModel(filterEntity.items),
      isActive: filterEntity.isActive,
    );
  }

  List<FilterItemModel> switchFilterItemsEntityToFilterItemsModel(
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
}
