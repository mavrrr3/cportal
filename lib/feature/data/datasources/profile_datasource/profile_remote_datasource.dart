import 'dart:developer';
import 'dart:io';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';

abstract class IProfileRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<ProfileModel> getSingleProfile(String id);

  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<List<ProfileModel>> searchProfiles(String query);
}

class ProfileRemoteDataSource implements IProfileRemoteDataSource {
  final IProfileLocalDataSource localDataSource;

  ProfileRemoteDataSource(this.localDataSource);
  @override
  Future<ProfileModel> getSingleProfile(String id) async {
    const String stringUser = '''
{
"id": "000000002",
"name": "Иванов Иван Иванович",
"departament": "Отдел вэб разработки",
"position": "Директор",
"birthdate": "2022-06-07T12:00:00",
"contacts": [
    {
        "type": "Рабочий телефон",
        "contact": "711-543"
    },
    {
        "type": "Личный номер телефона",
        "contact": "89128231848"
    },
    {
        "type": "Эл. почта",
        "contact": "ivanov@yandex.ru"
    }
],
"photo": "1.jpg"
}''';

    try {
      print('$stringUser');

      // TODO реализовать получение данных от API.
      final ProfileModel localeUser = profileModelFromJson(stringUser);
      log('$localeUser');

      await localDataSource.singleProfileToCache(localeUser);

      return localeUser;
    } on SocketException {
      throw ServerException();
    } on Exception catch (e) {
      log('Ошибка в методе ProfileRemoteDataSource: $e');
      rethrow;
    }
  }

  @override
  Future<List<ProfileModel>> searchProfiles(String query) {
    throw UnimplementedError();
  }
}
