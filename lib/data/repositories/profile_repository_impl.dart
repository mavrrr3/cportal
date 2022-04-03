import 'dart:convert';

import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/platform/network_info.dart';
import 'package:cportal_flutter/data/datasources/profile_remote_datasource.dart';
import 'package:cportal_flutter/data/models/profile_model.dart';
import 'package:cportal_flutter/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProfileEntity>> getSingleProfile(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.getSingleProfile(id);

        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        //TODO Реализовать обращение к локальным данным в случае отсутствия интернет соединения
        var stringUser = '''
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
        var jsonUser = json.decode(stringUser);
        ProfileModel localeUser = ProfileModel.fromJson(jsonUser);

        return Right(localeUser);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<ProfileEntity>>> searchProfiles(
    String query,
  ) async {
    try {
      final remoteUsers = await remoteDataSource.searchProfiles(query);

      return Right(remoteUsers);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
