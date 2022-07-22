import 'dart:math';

import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:local_auth/local_auth.dart';

class AuthUseCase {
  final IAuthRepository _authRepository;
  final IBiometricRepository _biometricRepository;

  AuthUseCase(
    this._authRepository,
    this._biometricRepository,
  );

  Future<BiometricType?> getEnabledBiometricType() => _biometricRepository.getEnabledBiometric();
}
