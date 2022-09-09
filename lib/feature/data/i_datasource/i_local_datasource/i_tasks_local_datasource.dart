import 'package:cportal_flutter/feature/data/models/documents/tasks/task_card_model.dart';

abstract class ITasksLocalDataSource {
  Future<int> fetchTotalCount(int query);
  Future<List<TaskCardModel>> fetchTasksFromCache(int page);
  Future<void> tasksToCache(
    List<TaskCardModel> tasks,
    int totalCount,
    int page,
  );
}
