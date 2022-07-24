import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/repositories/auth_repository.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<Failure, UserEntity>> logInWithConnectingCode({required String connectingCode});

  Future<void> logOut();

  Stream<AuthenticationStatus> get status;
}
