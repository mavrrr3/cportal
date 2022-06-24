import 'dart:developer';

import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class IFilterLocalDataSource {
  /// Извлекаем [List<FilterModel>] из кеша
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<FilterResponseModel> fetchFiltersFromCache();

  /// Сохраняем [List<FilterModel>] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<void> filtersToCache(FilterResponseModel filters, String endpoint);
}

class FilterLocalDataSource implements IFilterLocalDataSource {
  final HiveInterface hive;

  FilterLocalDataSource(this.hive);

  @override
  Future<FilterResponseModel> fetchFiltersFromCache() async {
    final box = await hive.openBox<FilterResponseModel>('filters');

    final filters = box.get('filters');

    if (kDebugMode) log('List<FilterModel> из кэша $filters');

    await Hive.box<FilterResponseModel>('filters').close();

    return filters!;
  }

  @override
  Future<void> filtersToCache(
    FilterResponseModel filters,
    String endPoint,
  ) async {
    // Удаляет box с диска.
    await Hive.deleteBoxFromDisk('filters_$endPoint');
    var box = await Hive.openBox<FilterResponseModel>('filters_$endPoint');
    if (!Hive.isBoxOpen('filters_$endPoint')) {
      await Hive.openBox<FilterResponseModel>('filters_$endPoint');
    } else {
      box = await Hive.openBox<FilterResponseModel>('filters_$endPoint');
    }

    log('FilterResponseModel сохранил в кэш ${filters.filters.length}');

    await box.put('filters_$endPoint', filters);

    await Hive.box<FilterResponseModel>('filters_$endPoint').close();
  }
}
