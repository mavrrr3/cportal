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
"id": "A1B2C3D4E5",
"external_id": "8877",
"first_name": "Александр",
"last_name": "Дымченко",
"middle_name": "Валерьевич",
"birthday": "20.11.1984",
"email": "aaa@novostal.ru",
"photo_link": "https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg",
"active": true,
"position": {
"id": "a1b2c3d4",
"description": "Начальник отдела",
"department": "Информационные технологии"
},
"phone": [
{
"number": "25-425-655",
"suffix": "033",
"primary": true
},
{
"number": "987-65-06",
"suffix": "033",
"primary": false
}
],
"user_created": "id_user_created",
"date_created": "2022-03-21T14:37:12.068Z",
"user_update": "id_user_updated",
"date_updated": "2022-03-21T14:37:12.068Z"
}''';

    try {
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
