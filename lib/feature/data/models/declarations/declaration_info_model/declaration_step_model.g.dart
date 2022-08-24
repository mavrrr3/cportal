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
      id: fields[0] as String,
      date: fields[1] as DateTime,
      responsibleName: fields[2] as String,
      responsiblePosition: fields[3] as String,
      responsibleImage: fields[4] as String,
      status: fields[5] as DeclarationStepStatusEnum,
      description: fields[6] as String,
      descrtiptionEnum: fields[7] as DescriptionEnum,
      expiresDate: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationStepModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.responsibleName)
      ..writeByte(3)
      ..write(obj.responsiblePosition)
      ..writeByte(4)
      ..write(obj.responsibleImage)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.descrtiptionEnum)
      ..writeByte(8)
      ..write(obj.expiresDate);
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
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      responsibleName: json['responsible_name'] as String,
      responsiblePosition: json['responsible_position'] as String,
      responsibleImage: json['responsible_image'] as String,
      status: $enumDecodeNullable(
              _$DeclarationStepStatusEnumEnumMap, json['status']) ??
          DeclarationStepStatusEnum.inProcess,
      description: json['description'] as String,
      descrtiptionEnum:
          $enumDecode(_$DescriptionEnumEnumMap, json['description_enum']),
      expiresDate: DateTime.parse(json['expires_date'] as String),
    );

const _$DeclarationStepStatusEnumEnumMap = {
  DeclarationStepStatusEnum.inProcess: 'В работе',
  DeclarationStepStatusEnum.expired: 'Просрочено',
  DeclarationStepStatusEnum.completed: 'Выполнено',
  DeclarationStepStatusEnum.completedWithComment: 'Выполнено с комментарием',
  DeclarationStepStatusEnum.declined: 'Отклонено',
};

const _$DescriptionEnumEnumMap = {
  DescriptionEnum.def: 'Стандартный',
  DescriptionEnum.task: 'Задача',
  DescriptionEnum.expired: 'Истек срок',
};
