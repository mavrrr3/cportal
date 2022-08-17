// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'declaration_step_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeclarationStepModelAdapter extends TypeAdapter<DeclarationStepModel> {
  @override
  final int typeId = 17;

  @override
  DeclarationStepModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeclarationStepModel(
      title: fields[0] as String,
      date: fields[1] as DateTime,
      status: fields[2] as DeclarationStatusEnum,
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationStepModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationStepModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclarationStepModel _$DeclarationStepModelFromJson(
        Map<String, dynamic> json) =>
    DeclarationStepModel(
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      status: $enumDecode(_$DeclarationStatusEnumEnumMap, json['status']),
    );

const _$DeclarationStatusEnumEnumMap = {
  DeclarationStatusEnum.done: 'Стандартный',
  DeclarationStatusEnum.inProcess: 'Стандартный',
  DeclarationStatusEnum.declined: 'Стандартный',
};
