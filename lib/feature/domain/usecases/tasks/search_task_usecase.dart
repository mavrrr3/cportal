import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_card_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_tasks_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';

class SearchTaskUseCase
    extends IUseCase<List<TaskCardEntity>, SearchTasksParams> {
  final ITasksRepository repository;

  SearchTaskUseCase(this.repository);

  @override
  Future<Either<Failure, List<TaskCardEntity>>> call(
    SearchTasksParams params,
  ) async =>
      repository.searchTasks(params.query);
}

class SearchTasksParams extends Equatable {
  final String query;

  const SearchTasksParams({required this.query});
  @override
  List<Object?> get props => [query];
}
