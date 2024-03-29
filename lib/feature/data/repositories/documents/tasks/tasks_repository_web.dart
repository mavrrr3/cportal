import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_tasks_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/declaration_info_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/tasks_response_model.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_card_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_tasks_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class TasksRepositoryWeb extends ITasksRepository {
  final ITasksRemoteDataSource remoteDataSource;

  TasksRepositoryWeb({required this.remoteDataSource});

  @override
  Future<Either<Failure, TasksResponseModel>> fetchTasks(int page) async {
    try {
      final remoteTasks = await remoteDataSource.fetchTasks(page);

      return Right(remoteTasks);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, DeclarationInfoModel>> getSingleTask(String id) async {
    try {
      final remoteTaskInfo = await remoteDataSource.getSingleTask(id);

      return Right(remoteTaskInfo);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskCardEntity>>> searchTasks(
    String query,
  ) {
    throw UnimplementedError();
  }
}
