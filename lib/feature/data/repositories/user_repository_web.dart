import 'package:cportal_flutter/core/error/cache_exception.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_user_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/user_model.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryWeb implements IUserRepository {
  final IUserRemoteDataSource remoteDataSource;
  final IUserLocalDataSource localDataSource;

  UserRepositoryWeb({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> login(String connectingCode) async {
    try {
      final remoteUser = await remoteDataSource.login(connectingCode);

      return Right(remoteUser);
    } on ServerException {
      return Left(ServerFailure());
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
