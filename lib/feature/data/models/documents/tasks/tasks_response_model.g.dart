// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'tasks_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasksResponseModelAdapter extends TypeAdapter<TasksResponseModel> {
  @override
  final int typeId = 27;

  @override
  TasksResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TasksResponseModel(
      total: fields[0] as int,
      items: (fields[1] as List).cast<TaskCardModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TasksResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.total)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksResponseModel _$TasksResponseModelFromJson(Map<String, dynamic> json) =>
    TasksResponseModel(
      total: json['total'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => TaskCardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
