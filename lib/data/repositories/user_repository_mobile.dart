import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/platform/network_info.dart';
import 'package:cportal_flutter/data/datasources/user_datasource/user_local_datasource.dart';
import 'package:cportal_flutter/data/datasources/user_datasource/user_remote_datasource.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/data/models/user_model.dart';
import 'package:cportal_flutter/domain/repositories/i_user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryMobile implements IUserRepository {
  final IUserRemoteDataSource remoteDataSource;
  final IUserLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  UserRepositoryMobile({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserModel>> login(String connectingCode) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.login(connectingCode);

        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localUser = await localDataSource.getSingleUserFromCache();
        if (localUser == null) {
          return Left(CacheFailure());
        }

        return Right(localUser);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> checkAuth() async {
    try {
      final localUser = await localDataSource.getSingleUserFromCache();
      if (localUser == null) {
        return const Right(false);
      }

      return const Right(true);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }
}
