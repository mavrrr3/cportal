import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_card_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/tasks_response_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/tasks/fetch_tasks_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/tasks/search_task_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/tasks_bloc/tasks_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/tasks_bloc/tasks_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final FetchTasksUseCase fetchTasks;
  final SearchTaskUseCase searchTasks;

  int page = 1;

  TasksBloc({
    required this.fetchTasks,
    required this.searchTasks,
  }) : super(TasksEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FetchTasksEvent>(
      _onFetch,
      transformer: bloc_concurrency.droppable(),
    );
  }

  // Получение данных от API.
  FutureOr<void> _onFetch(
    FetchTasksEvent event,
    Emitter emit,
  ) async {
    List<TaskCardEntity> oldTasks = [];
    if (event.isFirstFetch) {
      page = 1;
    }
    if (state is TasksLoadedState && !event.isFirstFetch) {
      oldTasks = (state as TasksLoadedState).tasks;
    }

    emit(TasksLoadingState(
      oldTasks,
      isFirstFetch: event.isFirstFetch,
    ));
    log('$page');
    final failureOrTasks = await fetchTasks(
      FetchTasksParams(page: page),
    );
    void loadingTasks(TasksResponseEntity tasks) {
      page++;

      final tasksList = (state as TasksLoadingState).oldTasks;

      // ignore: cascade_invocations
      tasksList.addAll(tasks.items);

      log('Загрузилось ${tasksList.length} задач');

      emit(TasksLoadedState(
        tasks: tasksList,
        total: tasks.total,
      ));
    }

    failureOrTasks.fold(
      _mapFailureToMessage,
      loadingTasks,
    );

    debugPrint('Отработал эвент: $event');
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
