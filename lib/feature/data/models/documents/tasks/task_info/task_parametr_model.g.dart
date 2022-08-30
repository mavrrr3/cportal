// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task_parametr_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskParametrModelAdapter extends TypeAdapter<TaskParametrModel> {
  @override
  final int typeId = 26;

  @override
  TaskParametrModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskParametrModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskParametrModel obj) {
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
      other is TaskParametrModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskParametrModel _$TaskParametrModelFromJson(Map<String, dynamic> json) =>
    TaskParametrModel(
      json['title'] as String,
      json['value'] as String,
    );
