import 'dart:developer';

import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';

abstract class IFilterRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<List<FilterModel>> fetchFilters();
}

class FilterRemoteDataSource implements IFilterRemoteDataSource {
  final IFilterLocalDataSource localDatasource;

  FilterRemoteDataSource(this.localDatasource);

  @override
  Future<List<FilterModel>> fetchFilters() async {
    try {
      final remoteFilters = [
        _filter1,
        _filter2,
      ];

      log('FilterRemouteDataSource  ==========' + remoteFilters.toString());
      await localDatasource.filtersToCache(remoteFilters);

      return remoteFilters;
    } on ServerException {
      throw ServerFailure();
    }
  }
}

const FilterModel _filter1 = FilterModel(
  headline: 'Компания',
  items: [
    FilterItemModel(name: 'АЭМ3'),
    FilterItemModel(name: 'Новосталь-М'),
    FilterItemModel(name: 'Демедия'),
  ],
);

const FilterModel _filter2 = FilterModel(
  headline: 'Должность',
  items: [
    FilterItemModel(name: 'Информационные технологии'),
    FilterItemModel(name: 'Отдел кадров'),
    FilterItemModel(name: 'Служба безопасности'),
    FilterItemModel(name: 'Менеджеры по документообороту'),
    FilterItemModel(name: 'Отдел мобильной разработки'),
    FilterItemModel(name: 'Отдел продаж'),
    FilterItemModel(name: 'Производственный отдел'),
    FilterItemModel(name: 'Отдел сбыта'),
    FilterItemModel(name: 'Администрация'),
  ],
);
