import 'package:cportal_flutter/core/error/cache_exception.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_tasks_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_tasks_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/tasks_response_model.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_info_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_card_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_tasks_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';

class TasksRepositoryMobile extends ITasksRepository {
  final ITasksRemoteDataSource remoteDataSource;
  final ITasksLocalDataSource localDataSource;
  final INetworkInfo networkInfo;
  TasksRepositoryMobile({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TasksResponseModel>> fetchTasks(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTasks = await remoteDataSource.fetchTasks(page);
        if (remoteTasks.items.isNotEmpty) {
          await localDataSource.tasksToCache(
            remoteTasks.items,
            remoteTasks.total,
            page,
          );
        }

        return Right(remoteTasks);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTasks = await localDataSource.fetchTasksFromCache(page);

        return Right(
          TasksResponseModel(
            total: localTasks.length,
            items: localTasks,
          ),
        );
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, DeclarationInfoEntity>> getSingleTask(
    String id,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTaskInfo = await remoteDataSource.getSingleTask(id);

        return Right(remoteTaskInfo);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
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
