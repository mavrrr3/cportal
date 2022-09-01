import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_info_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_card_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/tasks_response_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

abstract class ITasksRepository {
  Future<Either<Failure, TasksResponseEntity>> fetchTasks(int page);
  Future<Either<Failure, DeclarationInfoEntity>> getSingleTask(String id);
  Future<Either<Failure, List<TaskCardEntity>>> searchTasks(String query);
}
