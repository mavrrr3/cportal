// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'declaration_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeclarationDataModelAdapter extends TypeAdapter<DeclarationDataModel> {
  @override
  final int typeId = 16;

  @override
  DeclarationDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeclarationDataModel(
      title: fields[0] as String,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationDataModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclarationDataModel _$DeclarationDataModelFromJson(
        Map<String, dynamic> json) =>
    DeclarationDataModel(
      title: json['title'] as String,
      value: json['value'] as String,
    );
