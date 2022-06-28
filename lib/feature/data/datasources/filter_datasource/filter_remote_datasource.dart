import 'dart:developer';

import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';

abstract class IFilterRemoteDataSource {
  // Пробрасываем ошибки через [ServerException].
  Future<FilterResponseModel> fetchContactsFilters();

  // Пробрасываем ошибки через [ServerException].
  Future<FilterResponseModel> fetchDeclarationsFilters();
}

class FilterRemoteDataSource implements IFilterRemoteDataSource {
  final IFilterLocalDataSource localDatasource;

  FilterRemoteDataSource(this.localDatasource);

  @override
  Future<FilterResponseModel> fetchContactsFilters() async {
    try {
      late FilterResponseModel remoteFilters;
      remoteFilters = _contactsFilter;

      log('FilterRemouteDataSource  ==========  $remoteFilters');
      await localDatasource.filtersToCache(remoteFilters, FilterType.contacts);

      return remoteFilters;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<FilterResponseModel> fetchDeclarationsFilters() async {
    try {
      late FilterResponseModel remoteFilters;

      remoteFilters = _declarationsFilter;

      log('FilterRemouteDataSource  ==========  $remoteFilters');
      await localDatasource.filtersToCache(remoteFilters, FilterType.declarations);

      return remoteFilters;
    } on ServerException {
      throw ServerFailure();
    }
  }
}

/// Mock фильтров для раздела "Контакты".
/// // ignore: prefer_const_constructors
// ignore: prefer_const_constructors
const FilterResponseModel _contactsFilter = FilterResponseModel(
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

/// Mock фильтров для раздела "Заявления".
const FilterResponseModel _declarationsFilter = FilterResponseModel(
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
