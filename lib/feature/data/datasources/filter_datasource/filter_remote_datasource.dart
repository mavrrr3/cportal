import 'dart:convert';
import 'dart:developer';

import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:dio/dio.dart';

class FilterRemoteDataSource implements IFilterRemoteDataSource {
  final IFilterLocalDataSource localDatasource;
  final Dio dio;

  FilterRemoteDataSource(
    this.localDatasource,
    this.dio,
  );

  @override
  Future<FilterResponseModel> fetchContactsFilters() async {
    try {
      const String baseUrl = 'http://ribadi.ddns.net:88/cportal/hs/api/contacts/filter/1.0';

      final response = await dio.get<String>(baseUrl);

      final remoteFilters = FilterResponseModel.fromJson(
        json.decode(response.data!) as Map<String, dynamic>,
      );

      log('FilterRemouteDataSource [contacts]  ==========  $remoteFilters');
      await localDatasource.filtersToCache(remoteFilters, FilterType.contacts);

      return remoteFilters;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<FilterResponseModel> fetchDeclarationsFilters() async {
    try {
      const FilterResponseModel remoteFilters = _declarationsFilter;

      log('FilterRemouteDataSource [declarations]  ==========  $remoteFilters');
      await localDatasource.filtersToCache(remoteFilters, FilterType.declarations);

      return remoteFilters;
    } on ServerException {
      throw ServerFailure();
    }
  }
}

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
