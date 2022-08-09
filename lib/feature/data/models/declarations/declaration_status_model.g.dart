// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'declaration_status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeclarationStatusModelAdapter
    extends TypeAdapter<DeclarationStatusModel> {
  @override
  final int typeId = 18;

  @override
  DeclarationStatusModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeclarationStatusModel(
      title: fields[0] as String,
      color: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationStatusModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationStatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclarationStatusModel _$DeclarationStatusModelFromJson(
        Map<String, dynamic> json) =>
    DeclarationStatusModel(
      title: json['title'] as String,
      color: json['color'] as String,
    );
