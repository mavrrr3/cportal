import 'package:cportal_flutter/feature/domain/entities/device/device_platform.dart';
import 'package:equatable/equatable.dart';

class ConnectingDeviceEntity extends Equatable {
  final String device;
  final String deviceDescription;
  final DevicePlatform platform;
  final DateTime lastConnection;
  final String location;

  const ConnectingDeviceEntity({
    required this.device,
    required this.deviceDescription,
    required this.platform,
    required this.lastConnection,
    required this.location,
  });

  @override
  List<Object?> get props => [
        device,
        deviceDescription,
        platform,
        lastConnection,
        location,
      ];
}
