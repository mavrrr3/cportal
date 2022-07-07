import 'dart:convert';
import 'dart:developer';

import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_declarations_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_declarations_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_model.dart';
import 'package:dio/dio.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class DeclarationsRemoteDataSource implements IDeclarationsRemoteDataSource {
  final IDeclarationsLocalDataSource localDataSource;
  final Dio dio;

  DeclarationsRemoteDataSource(this.localDataSource, this.dio);

  @override
  Future<List<DeclarationModel>> fetchDeclarations(int page) async {
    final String baseUrl = '${AppConfig.apiUri}/cportal/hs/api/contacts/1.0/?page=$page';
    try {
      log('====== ${AppConfig.authKey}');
      final response = await dio.get<String>(baseUrl);

      final jsonR = json.decode(response.data!) as Map<String, dynamic>;
      final declarations = List<DeclarationModel>.from(jsonR['response']
          .map((dynamic x) => DeclarationModel.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>);

      log('ContactsRemouteDataSource  ==========  ${declarations.length}');
      await localDataSource.declarationsToCache(declarations, page);

      return declarations;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<DeclarationInfoModel> getSingleDeclaration(String id) async {
    final String baseUrl = '${AppConfig.apiUri}/cportal/hs/api/declaration/1.0?id=$id';

    try {
      final response = await dio.get<String>(baseUrl);

      final declarationInfo = DeclarationInfoModel.fromJson(
        json.decode(response.data!) as Map<String, dynamic>,
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
