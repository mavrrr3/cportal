import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/platform/network_info.dart';
import 'package:cportal_flutter/data/datasources/user_remote_datasource.dart';
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
  Future<Either<Failure, bool>> logIn(String connectingCode) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.logIn(connectingCode);

        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    throw ServerFailure();
    // else {
    //   try {

    //     UserEntity localeUser = userModelFromJson(stringUser);

    //     return Right(localeUser);
    //   } on CacheException {
    //     return Left(CacheFailure());
    //   }
    // }
  }
}
