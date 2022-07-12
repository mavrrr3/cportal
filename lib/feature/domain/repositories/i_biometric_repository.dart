import 'package:local_auth/local_auth.dart';

abstract class IBiometricRepository {
  Future<bool> isSupportedBiometrics();

  Future<List<BiometricType>> getAvailableBiometrics();

  Future<bool> authenticate({required String localizedReason});

  Future<void> saveEnabledBiometric(BiometricType enabledBiometric);

  Future<BiometricType?> getEnabledBiometric();
}
