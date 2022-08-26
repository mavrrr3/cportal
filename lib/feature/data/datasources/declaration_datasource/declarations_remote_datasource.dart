import 'dart:developer';

import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_declarations_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_declarations_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/declaration_info_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_model.dart';
import 'package:dio/dio.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class DeclarationsRemoteDataSource implements IDeclarationsRemoteDataSource {
  final IDeclarationsLocalDataSource localDataSource;
  final Dio _dio;

  DeclarationsRemoteDataSource(this.localDataSource, this._dio);

  @override
  Future<List<DeclarationModel>> fetchDeclarations(int page) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/declaration/1.0?$page';
    try {
      log('====== ${AppConfig.authKey}');

      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );
      final declarations =
          List<DeclarationModel>.from(response.data!['response']['items'].map(
        (dynamic x) => DeclarationModel.fromJson(x as Map<String, dynamic>),
      ) as Iterable<dynamic>);

      log('Remote DataSource [Declarations count]  ${declarations.length}');
      await localDataSource.declarationsToCache(declarations, page);

      return declarations;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<DeclarationInfoModel> getSingleDeclaration(String id) async {
    log('--[getSingleDeclaration]--[id $id]');
    const String baseUrl =
        'http://ribadi.ddns.net:88/cportal/hs/api/declaration/1.0?id=000000001';

    try {
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      final declarationInfo = DeclarationInfoModel.fromJson(
        response.data!['response'] as Map<String, dynamic>,
      );
      log('Remote DataSource [Single Declaration] ${response.data}');

      return declarationInfo;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<List<DeclarationModel>> searchDeclaration(String text) {
    // TODO: implement searchDeclaration.
    throw UnimplementedError();
  }
}
