import 'dart:developer';

import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_tasks_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/declaration_info_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/task_card_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/tasks_response_model.dart';
import 'package:dio/dio.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class TasksRemoteDataSource implements ITasksRemoteDataSource {
  final Dio _dio;

  TasksRemoteDataSource(this._dio);

  @override
  Future<TasksResponseModel> fetchTasks(int page) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/task/1.0?page=$page';
    try {
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );
      final tasks = TasksResponseModel.fromJson(
        response.data!['response'] as Map<String, dynamic>,
      );

      log('[Remote DataSource] ${tasks.items.length} tasks was fetched');

      return tasks;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<DeclarationInfoModel> getSingleTask(String id) async {
    final String baseUrl = '${AppConfig.apiUri}/cportal/hs/api/task/1.0?id=$id';

    try {
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      final taskInfo = DeclarationInfoModel.fromJson(
        response.data!['response'] as Map<String, dynamic>,
      );
      log('[Remote DataSource] Single Task was fetched id: $id');

      return taskInfo;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<List<TaskCardModel>> searchTasks(String text) {
    throw UnimplementedError();
  }
}
