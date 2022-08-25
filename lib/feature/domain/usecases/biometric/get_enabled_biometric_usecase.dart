import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:local_auth/local_auth.dart';

class GetEnabledBiometricUseCase {
  final IBiometricRepository _biometricRepository;

  GetEnabledBiometricUseCase(
    this._biometricRepository,
  );

  Future<BiometricType?> call() => _biometricRepository.getEnabledBiometric();
}
