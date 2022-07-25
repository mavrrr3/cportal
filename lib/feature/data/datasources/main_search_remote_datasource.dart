import 'dart:developer';

import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_main_search_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/main_search_model.dart';
import 'package:dio/dio.dart';

class MainSearchRemoteDataSource implements IMainSearchRemoteDataSource {
  final Dio _dio;

  MainSearchRemoteDataSource(this._dio);
  @override
  Future<List<MainSearchModel>> search(String query) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/search/1.0/?q=$query';

    try {
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      log('MainSearchDeserializeModel ${response.data} ==========================================');
      final searchModel = MainSearchDeserializeModel.fromJson(response.data!);

      return searchModel.searchList;
    } on ServerException {
      throw ServerFailure();
    }
  }
}
