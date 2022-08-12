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
      // final declarations =
      //     List<DeclarationModel>.from(response.data!['response'].map(
      //   (dynamic x) => DeclarationModel.fromJson(x as Map<String, dynamic>),
      // ) as Iterable<dynamic>);

      // log('Remote DataSource [Declarations count]  ${declarations.length}');
      // await localDataSource.declarationsToCache(declarations, page);

      return mock;
      
      // return declarations;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<DeclarationInfoModel> getSingleDeclaration(String id) async {
    log('--[getSingleDeclaration]--[id $id]');
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

final mock = [
  DeclarationModel(
    id: '',
    title: 'Техподдержка. Не работает почта ',
    description: 'Не согласовано Кириловой А.Д.',
    date: DateTime(2022, 8, 18, 16, 34),
    status: 'Создано',
    statusColor: '2E90FA',
    isAllert: false,
  ),
  DeclarationModel(
    id: '',
    title: 'Пропуск. Петраков А. К. 28 февраля',
    description: 'Требуется ознакомление',
    date: DateTime(2022, 8, 18, 16, 34),
    expiresDate: DateTime(2022, 1, 12, 18, 00),
    status: 'В работе',
    statusColor: 'CF5AF8',
    isAllert: true,
  ),
  DeclarationModel(
    id: '',
    title: 'Техподдержка. Не работает почта ',
    description: 'Не согласовано Кириловой А.Д.',
    date: DateTime(2022, 8, 17, 16, 34),
    status: 'Создано',
    statusColor: '2E90FA',
    isAllert: false,
  ),
  DeclarationModel(
    id: '',
    title: 'Пропуск. Петраков А. К. 28 февраля',
    description: 'Требуется ознакомление',
    date: DateTime(2022, 8, 17, 16, 34),
    expiresDate: DateTime(2022, 1, 12, 18, 00),
    status: 'В работе',
    statusColor: 'CF5AF8',
    isAllert: true,
  ),
  DeclarationModel(
    id: '',
    title: 'Техподдержка. Не работает почта ',
    description: 'Не согласовано Кириловой А.Д.',
    date: DateTime(2022, 8, 17, 16, 34),
    status: 'Создано',
    statusColor: '2E90FA',
    isAllert: false,
  ),
  DeclarationModel(
    id: '',
    title: 'Пропуск. Петраков А. К. 28 февраля',
    description: 'Требуется ознакомление',
    date: DateTime(2022, 8, 17, 16, 34),
    expiresDate: DateTime(2022, 1, 12, 18, 00),
    status: 'В работе',
    statusColor: 'CF5AF8',
    isAllert: true,
  ),
  DeclarationModel(
    id: '',
    title: 'Техподдержка. Не работает почта ',
    description: 'Не согласовано Кириловой А.Д.',
    date: DateTime(2022, 8, 17, 16, 34),
    status: 'Создано',
    statusColor: '2E90FA',
    isAllert: false,
  ),
  DeclarationModel(
    id: '',
    title: 'Пропуск. Петраков А. К. 28 февраля',
    description: 'Требуется ознакомление',
    date: DateTime(2022, 8, 17, 16, 34),
    expiresDate: DateTime(2022, 1, 12, 18, 00),
    status: 'В работе',
    statusColor: 'CF5AF8',
    isAllert: true,
  ),
  DeclarationModel(
    id: '',
    title: 'Техподдержка. Не работает почта ',
    description: 'Не согласовано Кириловой А.Д.',
    date: DateTime(2022, 8, 17, 16, 34),
    status: 'Создано',
    statusColor: '2E90FA',
    isAllert: false,
  ),
  DeclarationModel(
    id: '',
    title: 'Пропуск. Петраков А. К. 28 февраля',
    description: 'Требуется ознакомление',
    date: DateTime(2022, 8, 17, 16, 34),
    expiresDate: DateTime(2022, 1, 12, 18, 00),
    status: 'В работе',
    statusColor: 'CF5AF8',
    isAllert: true,
  ),
];
