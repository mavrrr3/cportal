import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/platform/network_info.dart';
import 'package:cportal_flutter/domain/entities/User_entity.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:cportal_flutter/domain/repositories/User_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> logIn(String connectingCode) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await remoteDataSource.login(connectingCode);

        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    }

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
