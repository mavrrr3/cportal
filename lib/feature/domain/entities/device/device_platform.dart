import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_platform.g.dart';

@HiveType(typeId: 15)
enum DevicePlatform {
  @JsonValue('android')
  @HiveField(0)
  android,
  @JsonValue('ios')
  @HiveField(1)
  ios,
  @JsonValue('desktop')
  @HiveField(2)
  desktop,
  @JsonValue('')
  @HiveField(3)
  unknown,
}
