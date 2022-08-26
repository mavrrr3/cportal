// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task_status_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskStatusEnumAdapter extends TypeAdapter<TaskStatusEnum> {
  @override
  final int typeId = 21;

  @override
  TaskStatusEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskStatusEnum.inProccess;
      case 1:
        return TaskStatusEnum.expired;
      case 2:
        return TaskStatusEnum.finished;
      case 3:
        return TaskStatusEnum.finishedWithComment;
      case 4:
        return TaskStatusEnum.notAgreed;
      default:
        return TaskStatusEnum.inProccess;
    }
  }

  @override
  void write(BinaryWriter writer, TaskStatusEnum obj) {
    switch (obj) {
      case TaskStatusEnum.inProccess:
        writer.writeByte(0);
        break;
      case TaskStatusEnum.expired:
        writer.writeByte(1);
        break;
      case TaskStatusEnum.finished:
        writer.writeByte(2);
        break;
      case TaskStatusEnum.finishedWithComment:
        writer.writeByte(3);
        break;
      case TaskStatusEnum.notAgreed:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskStatusEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
