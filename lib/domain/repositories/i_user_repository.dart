import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserEntity>> login(String connectingCode);
  Future<Either<Failure, bool>> checkAuth();
}
