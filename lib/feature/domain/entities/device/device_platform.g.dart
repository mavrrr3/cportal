// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'device_platform.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DevicePlatformAdapter extends TypeAdapter<DevicePlatform> {
  @override
  final int typeId = 15;

  @override
  DevicePlatform read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DevicePlatform.android;
      case 1:
        return DevicePlatform.ios;
      case 2:
        return DevicePlatform.desktop;
      case 3:
        return DevicePlatform.unknown;
      default:
        return DevicePlatform.android;
    }
  }

  @override
  void write(BinaryWriter writer, DevicePlatform obj) {
    switch (obj) {
      case DevicePlatform.android:
        writer.writeByte(0);
        break;
      case DevicePlatform.ios:
        writer.writeByte(1);
        break;
      case DevicePlatform.desktop:
        writer.writeByte(2);
        break;
      case DevicePlatform.unknown:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DevicePlatformAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
