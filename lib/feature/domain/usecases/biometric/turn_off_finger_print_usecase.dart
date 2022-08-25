import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';

class TurnOffFingerPrintUseCase {
  final IBiometricRepository _biometricRepository;

  TurnOffFingerPrintUseCase(this._biometricRepository);

  Future<bool> call() => _biometricRepository.turnOffFingerPrintAuth();
}
