// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskCardModelAdapter extends TypeAdapter<TaskCardModel> {
  @override
  final int typeId = 22;

  @override
  TaskCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskCardModel(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      status: fields[2] as String,
      title: fields[3] as String,
      description: fields[4] as String,
      descriptionEnum: fields[5] as DescriptionEnum,
      descriptionDate: fields[6] as DateTime,
      userPhoto: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskCardModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.descriptionEnum)
      ..writeByte(6)
      ..write(obj.descriptionDate)
      ..writeByte(7)
      ..write(obj.userPhoto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskCardModel _$TaskCardModelFromJson(Map<String, dynamic> json) =>
    TaskCardModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      descriptionEnum: $enumDecodeNullable(
              _$DescriptionEnumEnumMap, json['description_enum']) ??
          DescriptionEnum.def,
      descriptionDate: DateTime.parse(json['description_date'] as String),
      userPhoto: json['photo'] as String?,
    );

const _$DescriptionEnumEnumMap = {
  DescriptionEnum.def: 'Стандартный',
  DescriptionEnum.task: 'Задача',
  DescriptionEnum.expired: 'Истек срок',
};
