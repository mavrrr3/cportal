import 'dart:developer';

import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class IFilterLocalDataSource {
  /// Извлекаем [List<FilterModel>] из кеша
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<List<FilterModel>> fetchFiltersFromCache();

  /// Сохраняем [List<FilterModel>] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<void> filtersToCache(List<FilterModel> filters);
}

class FilterLocalDataSource implements IFilterLocalDataSource {
  final HiveInterface hive;

  FilterLocalDataSource(this.hive);

  @override
  Future<List<FilterModel>> fetchFiltersFromCache() async {
    final box = await hive.openBox<List<FilterModel>>('filters');

    final filters = box.get('filters');

    if (kDebugMode) log('List<FilterModel> из кэша $filters');

    await Hive.box<List<FilterModel>>('filters').close();

    return filters!;
  }

  @override
  Future<void> filtersToCache(List<FilterModel> filters) async {
    if (kDebugMode) {
      log('List<FilterModel> сохранил в кэш');
    }

    final box = await hive.openBox<List<FilterModel>>('filters');

    await box.put('filters', filters);

    await Hive.box<List<FilterModel>>('filters').close();
  }
}
