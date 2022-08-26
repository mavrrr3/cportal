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
      date: fields[4] as DateTime,
      status: fields[5] as String,
      descriptionEnum: fields[3] as DescriptionEnum,
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
      ..write(obj.descriptionEnum)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.status);
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
      status: json['status'] as String,
      descriptionEnum: $enumDecodeNullable(
              _$DescriptionEnumEnumMap, json['description_enum']) ??
          DescriptionEnum.def,
    );

const _$DescriptionEnumEnumMap = {
  DescriptionEnum.def: 'Стандартный',
  DescriptionEnum.task: 'Задача',
  DescriptionEnum.expired: 'Истек срок',
};
