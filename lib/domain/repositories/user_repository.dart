import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getSingleUser(String id);
  Future<Either<Failure, List<UserEntity>>> searchUsers(String query);
}
