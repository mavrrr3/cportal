// ignore_for_file: avoid_function_literals_in_foreach_calls, unnecessary_parenthesis

import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_declarations_filters_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/i_filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_functions.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDeclarationsBloc extends Bloc<FilterEvent, FilterState>
    implements IFilterBLoc {
  final FetchDeclarationsFiltersUseCase fetchFilters;

  FilterDeclarationsBloc({required this.fetchFilters})
      : super(FilterEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FetchFiltersEvent>(
      onFetch,
      transformer: bloc_concurrency.sequential(),
    );
    on<FilterExpandSectionEvent>(
      onExpandSection,
      transformer: bloc_concurrency.sequential(),
    );
    on<FilterSelectItemEvent>(
      onSelect,
      transformer: bloc_concurrency.sequential(),
    );
    on<FilterRemoveItemEvent>(
      onRemove,
      transformer: bloc_concurrency.sequential(),
    );
    on<FilterRemoveAllEvent>(
      onRemoveAll,
      transformer: bloc_concurrency.sequential(),
    );
  }

  // Получение данных от API.
  @override
  FutureOr<void> onFetch(
    FetchFiltersEvent event,
    Emitter emit,
  ) async {
    final oldState = state;
    emit(FilterLoadingState());

    final failureOrFilters = await fetchFilters();

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
  @override
  FutureOr<void> onExpandSection(
    FilterExpandSectionEvent event,
    Emitter emit,
  ) async {
    if (state is FilterLoadedState) {
      final updatedFilters = FilterFunctions.expandSection(
        filters: (state as FilterLoadedState).declarationsFilters,
        index: event.index,
      );

      final newState = (state as FilterLoadedState)
          .copyWith(declarationsFilters: updatedFilters);

      emit(FilterLoadingState());
      emit(newState);
    }
  }

  // Обработка выбора пункта в фильтре.
  @override
  FutureOr<void> onSelect(
    FilterSelectItemEvent event,
    Emitter emit,
  ) {
    if (state is FilterLoadedState) {
      final updatedFilters = FilterFunctions.select(
        filters: (state as FilterLoadedState).declarationsFilters,
        filterIndex: event.filterIndex,
        itemIndex: event.itemIndex,
      );
      final newState = (state as FilterLoadedState)
          .copyWith(declarationsFilters: updatedFilters);

      emit(FilterLoadingState());
      emit(newState);
    }
  }

  // Обработка удаления пункта фильтра из вью выбранных.
  @override
  FutureOr<void> onRemove(
    FilterRemoveItemEvent event,
    Emitter emit,
  ) async {
    if (state is FilterLoadedState) {
      final updatedFilters = FilterFunctions.remove(
        filters: (state as FilterLoadedState).declarationsFilters,
        filterIndex: event.filterIndex,
        item: event.item,
      );
      final newState = (state as FilterLoadedState)
          .copyWith(declarationsFilters: updatedFilters);

      emit(FilterLoadingState());
      emit(newState);
    }
  }

  // Делает все выбранные пункты из стейта неактивными.
  @override
  FutureOr<void> onRemoveAll(
    FilterRemoveAllEvent event,
    Emitter emit,
  ) async {
    if (state is FilterLoadedState) {
      final updatedFilters = FilterFunctions.removeAll(
        filters: (state as FilterLoadedState).declarationsFilters,
      );
      final newState = (state as FilterLoadedState)
          .copyWith(declarationsFilters: updatedFilters);

      emit(FilterLoadingState());
      emit(newState);

      debugPrint('Отработал эвент: $event');
    }
  }

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
}
