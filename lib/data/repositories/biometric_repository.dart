import 'package:cportal_flutter/core/error/exception.dart';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/platform/biometric_info.dart';
import 'package:cportal_flutter/domain/repositories/i_biometric_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricRepository implements IBiometricRepository {
  final IBiometricInfo biometricInfo;

  BiometricRepository({
    required this.biometricInfo,
  });

  @override
  Future<Either<Failure, bool>> autheticate() async {
    try {
      final isAuth = await biometricInfo.autheticate();

      return Right(isAuth);
    } on PlatformException {
      return Left(PlatformFailure());
    }
  }

  @override
  Future<Either<Failure, List<BiometricType>>> getBiometrics() async {
    try {
      final listBiometric = await biometricInfo.getBiometrics();

      return Right(listBiometric);
    } on PlatformException {
      return Left(PlatformFailure());
    }
  }
}
