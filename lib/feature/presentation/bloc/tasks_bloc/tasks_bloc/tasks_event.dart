import 'package:equatable/equatable.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();
}

class FetchTasksEvent extends TasksEvent {
  final bool isFirstFetch;

  const FetchTasksEvent({this.isFirstFetch = false});

  @override
  List<Object> get props => [isFirstFetch];
}

class SearchTasksEvent extends TasksEvent {
  final String query;

  const SearchTasksEvent({required this.query});

  @override
  List<Object> get props => [query];
}
