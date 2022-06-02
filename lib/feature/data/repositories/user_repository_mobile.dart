import 'package:cportal_flutter/core/error/cache_exception.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/user_datasource/user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/user_datasource/user_remote_datasource.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/models/user_model.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_user_repository.dart';
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
        final localUser = await localDataSource.getCurrentUserFromCache();
        if (localUser == null) {
          return Left(CacheFailure());
        }

        return Right(localUser);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> checkAuth() async {
    try {
      final localUser = await localDataSource.getCurrentUserFromCache();
      if (localUser == null) {
        return const Right(false);
      }

      return const Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
