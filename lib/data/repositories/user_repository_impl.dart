import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/data/datasources/user_remote_datasource.dart';
import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, UserEntity>> getSingleUser(String id) async {
    try {
      final remoteUser = await remoteDataSource.getSingleUser(id);

      return Right(remoteUser);
    } on ServerException {
      return Left(ServerFailure());
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
