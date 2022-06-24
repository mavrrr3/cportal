import 'dart:developer';

import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';

abstract class IFilterRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<FilterResponseModel> fetchFilters(String endpoint);
}

class FilterRemoteDataSource implements IFilterRemoteDataSource {
  final IFilterLocalDataSource localDatasource;

  FilterRemoteDataSource(this.localDatasource);

  @override
  Future<FilterResponseModel> fetchFilters(String endpoint) async {
    try {
      late FilterResponseModel remoteFilters;
      // ignore: prefer-conditional-expressions
      if (endpoint == 'contacts') {
        remoteFilters = _filter1;
      } else {
        remoteFilters = _filter2;
      }

      log('FilterRemouteDataSource  ==========  $remoteFilters');
      await localDatasource.filtersToCache(remoteFilters, endpoint);

      return remoteFilters;
    } on ServerException {
      throw ServerFailure();
    }
  }
}

/// Контакты.
/// // ignore: prefer_const_constructors
// ignore: prefer_const_constructors
const FilterResponseModel _filter1 = FilterResponseModel(
  filters: [
    FilterModel(
      headline: 'Компания',
      items: [
        FilterItemModel(name: 'АЭМ3'),
        FilterItemModel(name: 'Новосталь-М'),
        FilterItemModel(name: 'Демедия'),
      ],
    ),
    FilterModel(
      headline: 'Отдел',
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
    ),
  ],
);

/// Заявления.
const FilterResponseModel _filter2 = FilterResponseModel(
  filters: [
    FilterModel(
      headline: 'Статус',
      items: [
        FilterItemModel(name: 'Одобрено'),
        FilterItemModel(name: 'Отклонено'),
        FilterItemModel(name: 'Обработка'),
      ],
    ),
    FilterModel(
      headline: 'Категория',
      items: [
        FilterItemModel(name: 'Отдел кадров'),
        FilterItemModel(name: 'Служба безопасности'),
        FilterItemModel(name: 'Информационные технологии'),
      ],
    ),
  ],
);
