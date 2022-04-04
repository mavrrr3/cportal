import 'dart:developer';
import 'dart:io';
import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/data/datasources/profile_local_datasource.dart';
import 'package:cportal_flutter/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<ProfileModel> getSingleProfile(String id);

  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<List<ProfileModel>> searchProfiles(String query);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileLocalDataSource localDataSource;

  ProfileRemoteDataSourceImpl(this.localDataSource);
  @override
  Future<ProfileModel> getSingleProfile(String id) async {
    String stringUser = '''
                          {
"id": "A1B2C3D4E5",
"external_id": "8877",
"first_name": "Ivan",
"last_name": "Ivanov",
"middle_name": "Ivanovich",
"email": "aaa@novostal.ru",
"photo_link": "http://www.bbb.ru/photo.png",
"active": true,
"position": {
"id": "a1b2c3d4",
"description": "Начальник отдела"
},
"phone": [
{
"number": "123-45-67",
"suffix": "033",
"primary": true
},
{
"number": "987-65-06",
"primary": false
}
],
"user_created": "id_user_created",
"date_created": "2022-03-21T14:37:12.068Z",
"user_update": "id_user_updated",
"date_updated": "2022-03-21T14:37:12.068Z"
}''';

    try {
      //TODO реализовать получение данных от API

      ProfileModel localeUser = profileModelFromJson(stringUser);
      log('$localeUser');

      await localDataSource.singleProfileToCache(localeUser);

      return localeUser;
    } on SocketException {
      throw ServerException();
    } catch (e) {
      log('Ошибка в методе ProfileRemoteDataSource: $e');
      rethrow;
    }
  }

  @override
  Future<List<ProfileModel>> searchProfiles(String query) {
    throw UnimplementedError();
  }
}
