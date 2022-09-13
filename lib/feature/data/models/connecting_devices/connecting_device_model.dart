// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/domain/entities/device/connecting_device_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/device/device_platform.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connecting_device_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 13)
class ConnectingDeviceModel extends ConnectingDeviceEntity {
  @JsonKey(fromJson: Uri.decodeComponent)
  @HiveField(0)
  final String device;
  @JsonKey(name: 'app', fromJson: Uri.decodeComponent)
  @HiveField(1)
  final String deviceDescription;
  @JsonKey(unknownEnumValue: DevicePlatform.unknown)
  @HiveField(2)
  final DevicePlatform platform;
  @JsonKey(name: 'date')
  @HiveField(3)
  final DateTime lastConnection;
  @JsonKey(fromJson: Uri.decodeComponent)
  @HiveField(4)
  final String location;

  const ConnectingDeviceModel(
    this.device,
    this.deviceDescription,
    this.platform,
    this.lastConnection,
    this.location,
  ) : super(
          device: device,
          deviceDescription: deviceDescription,
          platform: platform,
          lastConnection: lastConnection,
          location: location,
        );

  factory ConnectingDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$ConnectingDeviceModelFromJson(json);
}
