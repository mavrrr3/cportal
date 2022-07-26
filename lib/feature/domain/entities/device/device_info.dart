import 'package:cportal_flutter/feature/domain/entities/device/device_platform.dart';
import 'package:equatable/equatable.dart';

class DeviceInfo extends Equatable {
  final String name;
  final String osInformation;
  final DevicePlatform platform;

  const DeviceInfo({
    required this.name,
    required this.osInformation,
    required this.platform,
  });

  @override
  List<Object?> get props => [name, osInformation, platform];
}
