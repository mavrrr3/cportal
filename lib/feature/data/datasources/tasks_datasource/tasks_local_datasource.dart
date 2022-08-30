import 'dart:developer';

import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_tasks_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/task_card_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class TasksLocalDataSource implements ITasksLocalDataSource {
  final HiveInterface hive;

  TasksLocalDataSource(this.hive);

  @override
  Future<List<TaskCardModel>> fetchTasksFromCache(
    int page,
  ) async {
    var box = await Hive.openBox<List<TaskCardModel>>('tasks');

    if (!Hive.isBoxOpen('tasks')) {
      await Hive.openBox<List<TaskCardModel>>('tasks');
    } else {
      box = await Hive.openBox<List<TaskCardModel>>('tasks');
    }

    final tasks = box.get('tasks_page_$page');

    if (kDebugMode) {
      log('List<TaskCardModel> [page $page] из кэша $tasks');
    }

    await Hive.box<List<TaskCardModel>>('tasks').close();

    return tasks!;
  }

  @override
  Future<void> tasksToCache(
    List<TaskCardModel> tasks,
    int page,
  ) async {
    // Удаляет box с диска.
    // await Hive.deleteBoxFromDisk('tasks');
    var box = await Hive.openBox<List<TaskCardModel>>('tasks');
    if (!Hive.isBoxOpen('tasks')) {
      await Hive.openBox<List<TaskCardModel>>('tasks');
    } else {
      box = await Hive.openBox<List<TaskCardModel>>('tasks');
    }
    log('List<TaskCardModel> [page $page] сохранил в кэш ${tasks.length} задач');

    await box.put('tasks_page_$page', tasks);

    await Hive.box<List<TaskCardModel>>('tasks').close();
  }
}
