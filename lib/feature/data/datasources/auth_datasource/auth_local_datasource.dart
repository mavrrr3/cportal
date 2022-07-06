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
  Future<String> getDeviceName() async {
    final deviceInfo = await _deviceInfoPlugin.deviceInfo;
    final mappedInfo = deviceInfo.toMap();

    if (kIsWeb) {
      return mappedInfo['appVersion'] as String;
    }

    return mappedInfo['name'] as String;
  }
}
