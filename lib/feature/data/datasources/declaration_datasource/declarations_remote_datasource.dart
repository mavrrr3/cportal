import 'dart:developer';

import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_declarations_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_declarations_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_data_model.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_enum.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_info_model.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_status_enum.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_step_model.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_model.dart';
import 'package:cportal_flutter/feature/data/models/user/declaration_user_model.dart';
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
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/declaration/1.0?id=$id';

    try {
      // final response = await _dio.fetch<Map<String, dynamic>>(
      //   Options(method: 'GET', responseType: ResponseType.json).compose(
      //     _dio.options,
      //     baseUrl,
      //   ),
      // );

      // final declarationInfo = DeclarationInfoModel.fromJson(
      //   response.data!['response'] as Map<String, dynamic>,
      // );
      // log('Remote DataSource [Single Declaration] ${response.data}');

      return _declarationInfoMock;
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

final _declarationInfoMock = DeclarationInfoModel(
  id: '0000001',
  title: 'Заявление на пропуск',
  progress: 0.75,
  type: DeclarationEnum.def,
  date: DateTime(2022, 08, 17, 16, 55),
  priority: 'Средний',
  initiator: DeclarationUserModel(
    id: '1111111',
    fullName: 'Кириллова Анна Дмитриевна',
    position: 'UI/UX Дизайнер',
    image: '',
  ),
  responsible: DeclarationUserModel(
    id: '2222222',
    fullName: 'Погорельцев Дмитрий Евгеньевич',
    position: 'Начальник отдела',
    image: '',
  ),
  steps: [
    DeclarationStepModel(
      title: 'Заявка создана',
      date: DateTime(2022, 7, 1, 15, 21, 42),
      status: DeclarationStatusEnum.done,
    ),
    DeclarationStepModel(
      title: 'Принято Службой безопасности',
      date: DateTime(2022, 7, 3, 11, 15, 38),
      status: DeclarationStatusEnum.done,
    ),
    DeclarationStepModel(
      title: 'На проверке службой безопасности',
      date: DateTime(2022, 7, 4, 17, 42, 12),
      status: DeclarationStatusEnum.inProcess,
    ),
  ],
  documents: [],
  data: [
    DeclarationDataModel(
      title: 'ФИО посетителя',
      description: 'Игумнов Тимофей Андреевич',
    ),
    DeclarationDataModel(
      title: 'Паспортные данные посетителя',
      description: '45 56 678876',
    ),
    DeclarationDataModel(
      title: 'Дата визита',
      description: '12.01.2022',
    ),
    DeclarationDataModel(
      title: 'Контактный телефон',
      description: '+7 923 456 67 78',
    ),
  ],
);
