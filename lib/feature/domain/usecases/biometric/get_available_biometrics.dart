import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:local_auth/local_auth.dart';

class GetAvailableBiometrics {
  final IBiometricRepository _biometricRepository;

  GetAvailableBiometrics(this._biometricRepository);

  Future<BiometricType?> call() async {
    final isSupportedBiometric =
        await _biometricRepository.isSupportedBiometrics();

    if (isSupportedBiometric) {
      final biometricTypes =
          await _biometricRepository.getAvailableBiometrics();

      if (biometricTypes.contains(BiometricType.fingerprint)) {
        return BiometricType.fingerprint;
      } else if (biometricTypes.contains(BiometricType.face)) {
        return BiometricType.face;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
