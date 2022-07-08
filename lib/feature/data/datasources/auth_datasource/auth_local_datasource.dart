import 'dart:io';

import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_auth_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSource implements IAuthLocalDataSource {
  final HiveInterface _hive;
  final DeviceInfoPlugin _deviceInfoPlugin;

  AuthLocalDataSource(this._hive, this._deviceInfoPlugin);

  @override
  Future<UserModel?> getCachedUser() async {
    final box = await _hive.openBox<UserModel>('user');

    return box.get('user');
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final box = await _hive.openBox<UserModel>('user');
    await box.put('user', user);
  }

  @override
  Future<String?> getDeviceName() async {
    if (kIsWeb) {
      final info = await _deviceInfoPlugin.webBrowserInfo;

      return info.userAgent;
    }
    if (Platform.isAndroid) {
      final info = await _deviceInfoPlugin.androidInfo;

      return info.model;
    } else if (Platform.isIOS) {
      final info = await _deviceInfoPlugin.iosInfo;

      return info.name;
    } else if (Platform.isLinux) {
      final info = await _deviceInfoPlugin.linuxInfo;

      return info.prettyName;
    } else if (Platform.isMacOS) {
      final info = await _deviceInfoPlugin.macOsInfo;

      return info.model;
    } else if (Platform.isWindows) {
      final info = await _deviceInfoPlugin.windowsInfo;

      return info.computerName;
    }

    return null;
  }
}
