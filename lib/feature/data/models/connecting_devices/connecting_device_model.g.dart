// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'connecting_device_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConnectingDeviceModelAdapter extends TypeAdapter<ConnectingDeviceModel> {
  @override
  final int typeId = 13;

  @override
  ConnectingDeviceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConnectingDeviceModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as DevicePlatform,
      fields[3] as DateTime,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ConnectingDeviceModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.device)
      ..writeByte(1)
      ..write(obj.deviceDescription)
      ..writeByte(2)
      ..write(obj.platform)
      ..writeByte(3)
      ..write(obj.lastConnection)
      ..writeByte(4)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectingDeviceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectingDeviceModel _$ConnectingDeviceModelFromJson(
        Map<String, dynamic> json) =>
    ConnectingDeviceModel(
      Uri.decodeComponent(json['device'] as String),
      Uri.decodeComponent(json['app'] as String),
      $enumDecode(_$DevicePlatformEnumMap, json['platform'],
          unknownValue: DevicePlatform.unknown),
      DateTime.parse(json['date'] as String),
      Uri.decodeComponent(json['location'] as String),
    );

const _$DevicePlatformEnumMap = {
  DevicePlatform.android: 'android',
  DevicePlatform.ios: 'ios',
  DevicePlatform.desktop: 'desktop',
  DevicePlatform.unknown: '',
};
