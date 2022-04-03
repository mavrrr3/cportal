import 'dart:convert';

import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/platform/network_info.dart';
import 'package:cportal_flutter/data/datasources/user_remote_datasource.dart';
import 'package:cportal_flutter/data/models/user_model.dart';
import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> getSingleUser(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.getSingleUser(id);

        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        //TODO Реализовать обращение к локальным данным в случае отсутствия интернет соединения
        var stringUser = '''
                          {
                            "id": "983636252",
                            "user_name": "login",
                            "profile_id": "2828287272",
                            "last_login": "2022-03-21T14:59:58.884Z",
                            "blocked": false,
                            "date_created": "2022-03-21T14:59:58.884Z",
                            "user_created": "838383",
                            "date_updated": null,
                            "user_updated": "",
                            "user_type": {
                              "id": "01",
                              "code": "A",
                              "description": "Администратор"
                            }}''';
        var jsonUser = json.decode(stringUser);
        UserModel localeUser = UserModel.fromJson(jsonUser);

        return Right(localeUser);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> searchUsers(String query) async {
    try {
      final remoteUsers = await remoteDataSource.searchUsers(query);

      return Right(remoteUsers);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
