// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task_document_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskDocumentModelAdapter extends TypeAdapter<TaskDocumentModel> {
  @override
  final int typeId = 24;

  @override
  TaskDocumentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskDocumentModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskDocumentModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.file);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskDocumentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDocumentModel _$TaskDocumentModelFromJson(Map<String, dynamic> json) =>
    TaskDocumentModel(
      json['title'] as String,
      json['file'] as String,
    );
