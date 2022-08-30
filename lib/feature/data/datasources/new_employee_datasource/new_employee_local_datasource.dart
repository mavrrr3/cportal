import 'dart:developer';

import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_new_employee_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/new_employee_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class NewEmployeeLocalDataSource implements INewEmployeeLocalDataSource {
  final HiveInterface hive;

  NewEmployeeLocalDataSource(this.hive);

  @override
  Future<List<NewEmployeeModel>> fetchNewEmployeeOnboardingSlidesFromCache() async {
    final box = await getOpenBox<List<NewEmployeeModel>>('newEmployee');

    final slides = box.get('newEmployee');

    if (kDebugMode) log('NewEmployeeModel список из кэша ${slides!.length} элементов');

    await Hive.box<List<NewEmployeeModel>>('newEmployee').close();

    return slides!;
  }

  @override
  Future<void> newEmployeeSlidesToCache(List<NewEmployeeModel> slides) async {
    // Удаляет box с диска.
    // await Hive.deleteBoxFromDisk('news');
    final box = await getOpenBox<List<NewEmployeeModel>>('newEmployee');
    log('NewsModel сохранил в кэш ${slides.length}');

    await box.put('newEmployee', slides);

    await Hive.box<List<NewEmployeeModel>>('newEmployee').close();
  }
}

Future<Box<T>> getOpenBox<T>(String boxName) async {
  Box<T> box = await Hive.openBox<T>(boxName);

  if (!Hive.isBoxOpen(boxName)) {
    await Hive.openBox<T>(boxName);
  } else {
    box = await Hive.openBox<T>(boxName);
  }

  return box;
}
