import 'package:cportal_flutter/feature/data/models/documents/tasks/task_card_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/task_info/task_info_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/tasks_response_model.dart';

abstract class ITasksRemoteDataSource {
  Future<TasksResponseModel> fetchTasks(int page);
  Future<TaskInfoModel> getSingleTask(String id);
  Future<List<TaskCardModel>> searchTasks(String text);
}
