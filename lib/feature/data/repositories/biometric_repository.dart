import 'dart:async';
import 'dart:developer';

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
  Future<List<BiometricType>> getAvailableBiometrics() =>
      _localAuthentication.getAvailableBiometrics();

  @override
  Future<bool> isSupportedBiometrics() async {
    try {
      final canCheckBiometrics = _localAuthentication.canCheckBiometrics;
      final isDeviceSupported = _localAuthentication.isDeviceSupported();

      final results =
          await Future.wait([canCheckBiometrics, isDeviceSupported]);

      return !results.any((res) => !res);
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<void> saveEnabledBiometric(BiometricType enabledBiometric) async {
    final box = await Hive.openBox<String>('biometric');
    if (enabledBiometric == BiometricType.face) {
      await box.put('biometric', '0');
    } else if (enabledBiometric == BiometricType.fingerprint) {
      await box.put('biometric', '1');
    } else {
      await box.put('biometric', '2');
    }

    log(enabledBiometric.toString());
    await _localAuthentication.isDeviceSupported();
  }

  @override
  Future<BiometricType?> getEnabledBiometric() async {
    final box = await Hive.openBox<String>('biometric');

    final biometricType = box.get('biometric');
    switch (biometricType) {
      case '0':
        return BiometricType.face;
      case '1':
        return BiometricType.fingerprint;
      default:
        return null;
    }
  }

  @override
  Future<bool> isFingerPrintEnabled() async {
    final enabledBiometric = await getEnabledBiometric();

    if (enabledBiometric != null &&
        enabledBiometric == BiometricType.fingerprint) {
      return true;
    }

    return false;
  }

  @override
  Future<bool> turnOffFingerPrintAuth() async {
    await saveEnabledBiometric(BiometricType.iris);

    return _localAuthentication.stopAuthentication();
  }
}
