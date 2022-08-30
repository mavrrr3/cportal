// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskInfoModelAdapter extends TypeAdapter<TaskInfoModel> {
  @override
  final int typeId = 23;

  @override
  TaskInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskInfoModel(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      title: fields[2] as String,
      status: fields[3] as String,
      currentStep: fields[4] as int,
      allSteps: fields[5] as int,
      description: fields[6] as String,
      descriptionEnum: fields[7] as DescriptionEnum,
      content: fields[8] as String,
      priority: fields[9] as String,
      initiatorName: fields[10] as String,
      initiatorPosition: fields[11] as String,
      initiatorImage: fields[12] as String,
      documents: (fields[13] as List).cast<TaskDocumentModel>(),
      parametrs: (fields[14] as List).cast<TaskParametrModel>(),
      actions: (fields[15] as List).cast<TaskActionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskInfoModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.currentStep)
      ..writeByte(5)
      ..write(obj.allSteps)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.descriptionEnum)
      ..writeByte(8)
      ..write(obj.content)
      ..writeByte(9)
      ..write(obj.priority)
      ..writeByte(10)
      ..write(obj.initiatorName)
      ..writeByte(11)
      ..write(obj.initiatorPosition)
      ..writeByte(12)
      ..write(obj.initiatorImage)
      ..writeByte(13)
      ..write(obj.documents)
      ..writeByte(14)
      ..write(obj.parametrs)
      ..writeByte(15)
      ..write(obj.actions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskInfoModel _$TaskInfoModelFromJson(Map<String, dynamic> json) =>
    TaskInfoModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      status: json['status'] as String,
      currentStep: json['current_step'] as int,
      allSteps: json['all_steps'] as int,
      description: json['description'] as String,
      descriptionEnum: $enumDecodeNullable(
              _$DescriptionEnumEnumMap, json['description_enum']) ??
          DescriptionEnum.def,
      content: json['content'] as String,
      priority: json['priority'] as String,
      initiatorName: json['initiator_name'] as String,
      initiatorPosition: json['initiator_position'] as String,
      initiatorImage: json['initiator_image'] as String,
      documents: (json['documents'] as List<dynamic>?)
              ?.map(
                  (e) => TaskDocumentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      parametrs: (json['parameters'] as List<dynamic>?)
              ?.map(
                  (e) => TaskParametrModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      actions: (json['actions'] as List<dynamic>?)
              ?.map((e) => TaskActionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

const _$DescriptionEnumEnumMap = {
  DescriptionEnum.def: 'Стандартный',
  DescriptionEnum.task: 'Задача',
  DescriptionEnum.expired: 'Истек срок',
};
