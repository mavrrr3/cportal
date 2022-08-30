import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_card_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_tasks_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:equatable/equatable.dart';

class FetchTasksUseCase
    extends IUseCase<List<TaskCardEntity>, FetchTasksParams> {
  final ITasksRepository repository;

  FetchTasksUseCase(this.repository);

  @override
  Future<Either<Failure, List<TaskCardEntity>>> call(
    FetchTasksParams params,
  ) async =>
      repository.fetchTasks(params.page);
}

class FetchTasksParams extends Equatable {
  final int page;

  const FetchTasksParams({required this.page});
  @override
  List<Object?> get props => [page];
}
