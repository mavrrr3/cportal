import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:cportal_flutter/feature/domain/entities/device/device_info.dart';

abstract class IAuthLocalDataSource {
  Future<void> saveUser(UserModel user);

  Future<UserModel?> getCachedUser();

  Future<DeviceInfo> getDeviceInfo();
}
