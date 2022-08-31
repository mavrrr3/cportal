import 'dart:developer';

import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_declarations_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/declaration_info_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_card_model.dart';
import 'package:dio/dio.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class DeclarationsRemoteDataSource implements IDeclarationsRemoteDataSource {
  final Dio _dio;

  DeclarationsRemoteDataSource(this._dio);

  @override
  Future<List<DeclarationCardModel>> fetchDeclarations(int page) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/declaration/1.0?page=$page';
    try {
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      final declarations = List<DeclarationCardModel>.from(
        response.data!['response']['items'].map(
          (dynamic x) =>
              DeclarationCardModel.fromJson(x as Map<String, dynamic>),
        ) as Iterable<dynamic>,
      );

      log('Remote DataSource [Declarations count]  ${declarations.length}');

      return declarations;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<DeclarationInfoModel> getSingleDeclaration(String id) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/declaration/1.0?id=$id';

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
      log('Remote DataSource [Single Declaration] was loaded id: $id');

      return declarationInfo;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<List<DeclarationCardModel>> searchDeclaration(String text) {
    // TODO: implement searchDeclaration.
    throw UnimplementedError();
  }
}
