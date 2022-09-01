import 'dart:developer';

import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_tasks_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/task_card_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class TasksLocalDataSource implements ITasksLocalDataSource {
  final HiveInterface hive;

  TasksLocalDataSource(this.hive);

  @override
  Future<List<TaskCardModel>> fetchTasksFromCache(int page) async {
    var box = await Hive.openBox<List<TaskCardModel>>('tasks');

    if (!Hive.isBoxOpen('tasks')) {
      await Hive.openBox<List<TaskCardModel>>('tasks');
    } else {
      box = await Hive.openBox<List<TaskCardModel>>('tasks');
    }

    final tasks = box.get('tasks_page_$page');

    if (kDebugMode) {
      log('[Local Datasource] Tasks [page $page] из кэша $tasks');
    }

    await Hive.box<List<TaskCardModel>>('tasks').close();

    return tasks!;
  }

  @override
  Future<void> tasksToCache(
    List<TaskCardModel> tasks,
    int totalCount,
    int page,
  ) async {
    // Удаляет box с диска.
    // await Hive.deleteBoxFromDisk('tasks');
    var box = await Hive.openBox<List<TaskCardModel>>('tasks');
    var boxTotal = await Hive.openBox<int>('tasks_total');

    if (!Hive.isBoxOpen('tasks')) {
      await Hive.openBox<List<TaskCardModel>>('tasks');
    } else {
      box = await Hive.openBox<List<TaskCardModel>>('tasks');
    }

    if (!Hive.isBoxOpen('tasks_total')) {
      await Hive.openBox<int>('tasks_total');
    } else {
      boxTotal = await Hive.openBox<int>('tasks_total');
    }

    await box.put('tasks_page_$page', tasks);
    await boxTotal.put('tasks_total', totalCount);

    log('[Local Datasource] Tasks [page $page] сохранил в кэш ${tasks.length} задач\nTasks Total Count сохранил в кэш $totalCount');

    await Hive.box<List<TaskCardModel>>('tasks').close();
    await Hive.box<int>('tasks_total').close();
  }

  @override
  Future<int> fetchTotalCount(int query) async {
    var box = await Hive.openBox<int>('tasks_total');

    if (!Hive.isBoxOpen('tasks_total')) {
      await Hive.openBox<int>('tasks_total');
    } else {
      box = await Hive.openBox<int>('tasks_total');
    }

    final totalCount = box.get('tasks_total');

    log('Tasks Total из кэша - $totalCount');

    await Hive.box<int>('tasks_total').close();

    return totalCount ?? 0;
  }
}
