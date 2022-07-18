import 'package:cportal_flutter/feature/domain/entities/device_platform.dart';

class DeviceInfo {
  final String name;
  final String description;
  final DevicePlatform platform;

  DeviceInfo(
    this.name,
    this.description,
    this.platform,
  );
}
