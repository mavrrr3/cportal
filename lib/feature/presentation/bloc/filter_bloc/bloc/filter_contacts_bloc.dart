// ignore_for_file: avoid_function_literals_in_foreach_calls, unnecessary_parenthesis

import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_contacts_filters_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_functions.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterContactsBloc extends Bloc<FilterEvent, FilterState> {
  final FetchContactsFiltersUseCase fetchFilters;

  FilterContactsBloc({required this.fetchFilters}) : super(FilterEmptyState()) {
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
          newState = oldState.copyWith(contactsFilters: filters);
        }

        emit(newState ?? FilterLoadedState(contactsFilters: filters));
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
      final updatedFilters = onExpandSection(
        filters: (state as FilterLoadedState).contactsFilters,
        index: event.index,
      );
      final newState = (state as FilterLoadedState).copyWith(contactsFilters: updatedFilters);

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
       final updatedFilters = onSelect(
        filters: (state as FilterLoadedState).contactsFilters,
        filterIndex: event.filterIndex,
        itemIndex: event.itemIndex,
      );
      final newState = (state as FilterLoadedState).copyWith(contactsFilters: updatedFilters);


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
      final updatedFilters = onRemove(
        filters: (state as FilterLoadedState).contactsFilters,
        filterIndex: event.filterIndex,
        item: event.item,
      );
      final newState = (state as FilterLoadedState).copyWith(contactsFilters: updatedFilters);


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
      final updatedFilters = onRemoveAll(filters: (state as FilterLoadedState).contactsFilters);
      final newState = (state as FilterLoadedState).copyWith(contactsFilters: updatedFilters);

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
