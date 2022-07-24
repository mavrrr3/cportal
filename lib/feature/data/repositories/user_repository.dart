import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_user_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepository implements IUserRepository {
  final IUserLocalDataSource _userLocalDataSource;
  final IUserRemoteDataSource _userRemoteDataSource;

  UserRepository(
    this._userLocalDataSource,
    this._userRemoteDataSource,
  );

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    final localUser = await _userLocalDataSource.getUser();

    if (localUser == null) return Left(CacheFailure());

    try {
      final user = await _userRemoteDataSource.getUser(token: localUser.token);
      await _userLocalDataSource.saveUser(user);

      return Right(user);
    } on Exception catch (_) {
      return Right(localUser);
    }
  }

  @override
  Future<bool> hasCachedUser() async {
    try {
      final user = await _userLocalDataSource.getUser();

      return user != null;
    } on Exception catch (_) {
      return false;
    }
  }
}
