import 'package:json_annotation/json_annotation.dart';

enum DevicePlatform {
  @JsonValue('android')
  android,
  @JsonValue('ios')
  ios,
  @JsonValue('desktop')
  desktop,
}
