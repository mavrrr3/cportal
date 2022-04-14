import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

abstract class IBiometricInfo {
  /// Возвращает [bool] если девайс поддерживает биометрию
  ///
  /// Пробрасываем ошибки через [PlatformException]
  Future<bool> hasBiometrics();

  /// Возвращает список поодерживаемых типов [BiometricType] биометрии
  ///
  /// Пробрасываем ошибки через [PlatformException]
  Future<List<BiometricType>> getBiometrics();

  /// Возвращает [bool] если аутентифицирован
  ///
  /// Пробрасываем ошибки через [PlatformException]
  Future<bool> autheticate();
}

class BiometricInfo implements IBiometricInfo {
  final LocalAuthentication localAuth;

  BiometricInfo(this.localAuth);

  @override
  Future<bool> hasBiometrics() async {
    return await localAuth.canCheckBiometrics;
  }

  @override
  Future<List<BiometricType>> getBiometrics() async {
    return await localAuth.getAvailableBiometrics();
  }

  @override
  Future<bool> autheticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    return await localAuth.authenticate(
      localizedReason: 'Приложите ваш палец к сенсору для входа',
      useErrorDialogs: true,
      stickyAuth: true,
      iOSAuthStrings: _iosStrings,
      androidAuthStrings: _androidStrings,
    );
  }

  final IOSAuthMessages _iosStrings = const IOSAuthMessages(
    cancelButton: 'ОТМЕНА',
    goToSettingsButton: 'Настройки',
    goToSettingsDescription: 'Please set up your Touch ID.',
    lockOut: 'Please reenable your Touch ID',
  );

  final AndroidAuthMessages _androidStrings = const AndroidAuthMessages(
    cancelButton: 'ОТМЕНА',
    goToSettingsButton: 'Настройки',
    goToSettingsDescription: 'Please set up your Touch ID.',
  );
}
