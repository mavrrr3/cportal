import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connecting_devices_response.g.dart';

@JsonSerializable(createToJson: false)
class ConnectingDevicesResponse {
  final ConnectingDevicesModel response;

  ConnectingDevicesResponse(this.response);

  factory ConnectingDevicesResponse.fromJson(Map<String, dynamic> json) => _$ConnectingDevicesResponseFromJson(json);
}
