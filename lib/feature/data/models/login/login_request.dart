import 'package:cportal_flutter/feature/domain/entities/device/device_platform.dart';
import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String connectingCode;
  final String device;
  final String deviceDescription;
  final DevicePlatform platform;
  final String? location;

  const LoginRequest({
    required this.connectingCode,
    required this.device,
    required this.deviceDescription,
    required this.platform,
    required this.location,
  });

  @override
  List<Object?> get props => [connectingCode, device, deviceDescription, platform, location];
}
