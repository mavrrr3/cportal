import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_card_entity.dart';
import 'package:equatable/equatable.dart';

abstract class TasksState extends Equatable {
  const TasksState();
  @override
  List<Object?> get props => [];
}

class TasksEmptyState extends TasksState {}

class TasksLoadingState extends TasksState {
  final List<TaskCardEntity> oldTasks;
  final bool isFirstFetch;

  const TasksLoadingState(
    this.oldTasks, {
    this.isFirstFetch = false,
  });

  @override
  List<Object?> get props => [oldTasks, isFirstFetch];
}

class TasksLoadedState extends TasksState {
  final List<TaskCardEntity> tasks;
  final int total;

  const TasksLoadedState({
    required this.tasks,
    required this.total,
  });

  @override
  List<Object?> get props => [tasks];
}

class TasksFetchErrorState extends TasksState {
  final String message;

  const TasksFetchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
