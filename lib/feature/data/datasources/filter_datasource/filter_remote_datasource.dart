import 'dart:developer';

import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:dio/dio.dart';

class FilterRemoteDataSource implements IFilterRemoteDataSource {
  final IFilterLocalDataSource localDatasource;
  final Dio _dio;

  FilterRemoteDataSource(
    this.localDatasource,
    this._dio,
  );

  @override
  Future<FilterResponseModel> fetchContactsFilters() async {
    try {
      final String baseUrl =
          '${AppConfig.apiUri}/cportal/hs/api/contacts/filter/1.0';

      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      final remoteFilters = FilterResponseModel.fromJson(response.data!);

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
      await localDatasource.filtersToCache(
        remoteFilters,
        FilterType.declarations,
      );

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
