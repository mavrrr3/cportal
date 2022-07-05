import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:local_auth/local_auth.dart';

class AuthUseCase {
  final IAuthRepository _authRepository;
  final IPinCodeRepository _pinCodeRepository;
  final IBiometricRepository _biometricRepository;

  AuthUseCase(
    this._authRepository,
    this._pinCodeRepository,
    this._biometricRepository,
  );

  Future<UserEntity?> loginWithConnectingCode(String connectingCode) async {
    final userModel = await _authRepository.logInWithConnectingCode(connectingCode: connectingCode);

    return userModel?.toEntity();
  }

  Future<UserEntity?> logInWithPinCode(String pinCode) async {
    final pinIsMatched = await _pinCodeRepository.pinIsMatched(pinCode);

    if (pinIsMatched) {
      final userModel = await _authRepository.getUser();

      return userModel?.toEntity();
    }

    return null;
  }

  Future<UserEntity?> logInWithBiometric(String localizedReason) async {
    final isAuthenticated = await _biometricRepository.authenticate(localizedReason: localizedReason);

    if (isAuthenticated) {
      final userModel = await _authRepository.getUser();

      return userModel?.toEntity();
    }

    return null;
  }

  Future<bool> hasAuthCredentials() async {
    final isAuthenticated = await _authRepository.isAuthenticated();
    final hasPinCode = await _pinCodeRepository.hasPinCode();

    return isAuthenticated && hasPinCode;
  }

  Future<BiometricType?> getEnabledBiometricType() => _biometricRepository.getEnabledBiometric();
}
