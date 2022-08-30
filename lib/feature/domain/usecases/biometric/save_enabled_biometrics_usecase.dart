import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:local_auth/local_auth.dart';

class SaveEnabledBiometricsUseCase {
  final IBiometricRepository _biometricRepository;

  SaveEnabledBiometricsUseCase(
    this._biometricRepository,
  );

  Future<void> call(BiometricType enabledBiometric) =>
      _biometricRepository.saveEnabledBiometric(enabledBiometric);
}
