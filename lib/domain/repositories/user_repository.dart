import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> logIn(String connectingCode);
}
