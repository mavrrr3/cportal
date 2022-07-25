import 'dart:developer';
import 'dart:io';
import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_profile_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_profile_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';

class ProfileRemoteDataSource implements IProfileRemoteDataSource {
  final IProfileLocalDataSource localDataSource;
  final Dio dio;

  ProfileRemoteDataSource(this.localDataSource, this.dio);
  @override
  Future<ProfileModel> getSingleProfile(
    String id, {
    bool isMyProfile = false,
  }) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/contacts/1.0/?id=$id';

    try {
      // TODO: Избавиться от if, передавать эту переменную в singleProfileToCache.
      if (isMyProfile) {
        final ProfileModel localeUser = profileModelFromJson(stringUser);

        await localDataSource.singleProfileToCache(localeUser);

        return localeUser;
      } else {
        final response = await dio.fetch<Map<String, dynamic>>(
          Options(method: 'GET', responseType: ResponseType.json).compose(
            dio.options,
            baseUrl,
          ),
        );

        final profile = ProfileModel.fromJson(
          response.data!['response'] as Map<String, dynamic>,
        );

        log('ProfileRemouteDataSource  ==========  $profile');
        await localDataSource.singleProfileToCache(profile);

        return profile;
      }
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
"photo": "20220616/285831712_340931151553303_8302347002848994819_n.jpg"
}''';
