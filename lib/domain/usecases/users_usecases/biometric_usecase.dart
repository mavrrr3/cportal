import 'package:cportal_flutter/domain/repositories/i_biometric_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:local_auth/local_auth.dart';

class BiometricUseCase {
  final IBiometricRepository biometricInfo;

  BiometricUseCase(this.biometricInfo);

  Future<Either<Failure, bool>> autheticate() async {
    return await biometricInfo.autheticate();
  }

  Future<Either<Failure, List<BiometricType>>> getBiometrics() async {
    return await biometricInfo.getBiometrics();
  }
}
