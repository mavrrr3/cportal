// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'connecting_devices_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConnectingDevicesModelAdapter
    extends TypeAdapter<ConnectingDevicesModel> {
  @override
  final int typeId = 14;

  @override
  ConnectingDevicesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConnectingDevicesModel(
      count: fields[0] as int,
      items: (fields[1] as List).cast<ConnectingDeviceModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ConnectingDevicesModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectingDevicesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectingDevicesModel _$ConnectingDevicesModelFromJson(
        Map<String, dynamic> json) =>
    ConnectingDevicesModel(
      count: json['count'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => ConnectingDeviceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
