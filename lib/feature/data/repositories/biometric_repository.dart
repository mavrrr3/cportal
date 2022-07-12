import 'dart:async';

import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';

class BiometricRepository implements IBiometricRepository {
  final LocalAuthentication _localAuthentication;

  BiometricRepository(this._localAuthentication);

  @override
  Future<bool> authenticate({required String localizedReason}) {
    return _localAuthentication.authenticate(
      localizedReason: localizedReason,
      stickyAuth: true,
      biometricOnly: true,
    );
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() => _localAuthentication.getAvailableBiometrics();

  @override
  Future<bool> isSupportedBiometrics() async {
    try {
      final canCheckBiometrics = _localAuthentication.canCheckBiometrics;
      final isDeviceSupported = _localAuthentication.isDeviceSupported();

      final results = await Future.wait([canCheckBiometrics, isDeviceSupported]);

      return !results.any((res) => !res);
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<void> saveEnabledBiometric(BiometricType enabledBiometric) async {
    final box = await Hive.openBox<String>('biometric');
    if (enabledBiometric == BiometricType.face) {
      await box.add('0');
    } else {
      await box.add('1');
    }
  }

  @override
  Future<BiometricType?> getEnabledBiometric() async {
    final box = await Hive.openBox<String>('biometric');

    final biometricType = box.get(0);
    switch (biometricType) {
      case '0':
        return BiometricType.face;
      case '1':
        return BiometricType.fingerprint;
      default:
        return null;
    }
  }
}
