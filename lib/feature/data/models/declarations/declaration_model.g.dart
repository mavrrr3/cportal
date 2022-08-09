// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'declaration_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeclarationModelAdapter extends TypeAdapter<DeclarationModel> {
  @override
  final int typeId = 12;

  @override
  DeclarationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeclarationModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      date: fields[3] as DateTime,
      expiresDate: fields[4] as DateTime?,
      statuses: (fields[5] as List).cast<DeclarationStatusModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.expiresDate)
      ..writeByte(5)
      ..write(obj.statuses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclarationModel _$DeclarationModelFromJson(Map<String, dynamic> json) =>
    DeclarationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      expiresDate: json['expires_date'] == null
          ? null
          : DateTime.parse(json['expires_date'] as String),
      statuses: (json['statuses'] as List<dynamic>)
          .map(
              (e) => DeclarationStatusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
