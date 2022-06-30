import 'dart:developer';

import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class FilterLocalDataSource implements IFilterLocalDataSource {
  final HiveInterface hive;

  FilterLocalDataSource(this.hive);

  @override
  Future<FilterResponseModel> fetchFiltersFromCache(
    FilterType type,
  ) async {
    final box = await hive.openBox<FilterResponseModel>('filters_$type');

    final filters = box.get('filters_$type');

    if (kDebugMode) log('FilterResponseModel из кэша $filters');

    await Hive.box<FilterResponseModel>('filters_$type').close();

    return filters!;
  }

  @override
  Future<void> filtersToCache(
    FilterResponseModel filters,
    FilterType type,
  ) async {
    // Удаляет box с диска.
    await Hive.deleteBoxFromDisk('filters_$type');
    var box = await Hive.openBox<FilterResponseModel>('filters_$type');
    if (!Hive.isBoxOpen('filters_$type')) {
      await Hive.openBox<FilterResponseModel>('filters_$type');
    } else {
      box = await Hive.openBox<FilterResponseModel>('filters_$type');
    }

    log('FilterResponseModel сохранил в кэш ${filters.filters.length}');

    await box.put('filters_$type', filters);

    await Hive.box<FilterResponseModel>('filters_$type').close();
  }
}
