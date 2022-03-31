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
        const localeUser = UserModel(
          id: 'id',
          username: 'Изкэш Изкэшевич Изкешев',
          position: 'Мастер цеха №5',
          image:
              'https://demotivation.ru/wp-content/uploads/2021/01/scale_1200-1-768x403.jpg',
          department: 'Бухгалтерия',
          email: 'email@mail.ru',
          internalPhone: '43528',
          externalPhone: '+79997373838',
        );

        return const Right(localeUser);
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
