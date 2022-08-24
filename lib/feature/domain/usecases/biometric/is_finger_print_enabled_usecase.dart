import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';

class IsFingerPrintEnabledUsecase {
  final IBiometricRepository _biometricRepository;

  IsFingerPrintEnabledUsecase(this._biometricRepository);

  Future<bool> call() => _biometricRepository.isFingerPrintEnabled();
}
