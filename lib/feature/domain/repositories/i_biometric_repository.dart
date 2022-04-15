import 'package:cportal_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:local_auth/local_auth.dart';

abstract class IBiometricRepository {
  Future<Either<Failure, List<BiometricType>>> getBiometrics();

  Future<Either<Failure, bool>> autheticate();
}
