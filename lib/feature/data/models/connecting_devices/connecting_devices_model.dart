import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_device_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connecting_devices_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 14)
class ConnectingDevicesModel {
  @HiveField(0)
  final int count;
  @HiveField(1)
  final List<ConnectingDeviceModel> items;

  ConnectingDevicesModel({
    required this.count,
    required this.items,
  });

  factory ConnectingDevicesModel.empty() => ConnectingDevicesModel(count: 0, items: const []);

  factory ConnectingDevicesModel.fromJson(Map<String, dynamic> json) => _$ConnectingDevicesModelFromJson(json);
}
