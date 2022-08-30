import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_info/task_info_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_tasks_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';

class GetSingleTaskUseCase
    extends IUseCase<TaskInfoEntity, GetSingleTaskParams> {
  final ITasksRepository repository;

  GetSingleTaskUseCase(this.repository);

  @override
  Future<Either<Failure, TaskInfoEntity>> call(
    GetSingleTaskParams params,
  ) async {
    return repository.getSingleTask(params.id);
  }
}

class GetSingleTaskParams extends Equatable {
  final String id;

  const GetSingleTaskParams({required this.id});
  @override
  List<Object?> get props => [id];
}
