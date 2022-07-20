import 'dart:io';

import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_auth_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:cportal_flutter/feature/domain/entities/device/device_info.dart';
import 'package:cportal_flutter/feature/domain/entities/device/device_platform.dart';
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
  Future<DeviceInfo> getDeviceInfo() async {
    String? device;
    String? osInformation;
    DevicePlatform? platform = DevicePlatform.desktop;

    if (kIsWeb) {
      final info = await _deviceInfoPlugin.webBrowserInfo;
      device = '${info.vendor} ${info.vendorSub}';
      osInformation = 'Web';
    }
    if (Platform.isAndroid) {
      final info = await _deviceInfoPlugin.androidInfo;
      device = info.model;
      osInformation = 'Android ${info.version.baseOS}';
      platform = DevicePlatform.android;
    } else if (Platform.isIOS) {
      final info = await _deviceInfoPlugin.iosInfo;
      device = info.name;
      osInformation = '${info.systemName} ${info.systemVersion}';
      platform = DevicePlatform.ios;
    } else if (Platform.isLinux) {
      final info = await _deviceInfoPlugin.linuxInfo;
      device = info.prettyName;
      osInformation = 'Linux';
    } else if (Platform.isMacOS) {
      final info = await _deviceInfoPlugin.macOsInfo;
      device = info.model;
      osInformation = 'macOS ${info.osRelease}';
    } else if (Platform.isWindows) {
      device = 'Desktop';
      osInformation = 'Windows';
    }

    return DeviceInfo(
      name: device ?? '',
      osInformation: osInformation ?? '',
      platform: platform,
    );
  }
}
