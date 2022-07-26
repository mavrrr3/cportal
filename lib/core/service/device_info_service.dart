import 'dart:io';

import 'package:cportal_flutter/feature/domain/entities/device/device_info.dart';
import 'package:cportal_flutter/feature/domain/entities/device/device_platform.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin;

  DeviceInfoService(this._deviceInfoPlugin);

  Future<DeviceInfo> getDeviceInfo() async {
    String? device;
    String? osInformation;
    DevicePlatform? platform = DevicePlatform.desktop;

    if (kIsWeb) {
      final info = await _deviceInfoPlugin.webBrowserInfo;
      device = '${info.vendor} ${info.vendorSub}';
      osInformation = 'Web';
    } else if (Platform.isAndroid) {
      final info = await _deviceInfoPlugin.androidInfo;
      device = '${info.manufacturer} ${info.model}';
      osInformation = 'Android ${info.version.release}';
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
