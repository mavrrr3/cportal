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
      description: fields[6] as String,
      status: fields[7] as TaskStatusEnum,
      descriptionDate: fields[8] as DateTime,
      comment: fields[9] as String,
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
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.descriptionDate)
      ..writeByte(9)
      ..write(obj.comment);
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
      description: json['description'] as String,
      status: $enumDecodeNullable(
              _$TaskStatusEnumEnumMap, json['description_enum']) ??
          TaskStatusEnum.inProccess,
      descriptionDate: DateTime.parse(json['description_date'] as String),
      comment: json['comment'] as String,
    );

const _$TaskStatusEnumEnumMap = {
  TaskStatusEnum.inProccess: 'Ожидание исполнения задачи',
  TaskStatusEnum.expired: 'Просрочил выполнение задачи',
  TaskStatusEnum.finished: 'Задача исполнена',
  TaskStatusEnum.finishedWithComment: 'Задача исполнена с комментарием',
  TaskStatusEnum.notAgreed: 'Заявление не согласовано',
};
