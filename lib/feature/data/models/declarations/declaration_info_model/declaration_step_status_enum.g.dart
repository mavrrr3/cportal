// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'declaration_step_status_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeclarationStepStatusEnumAdapter
    extends TypeAdapter<DeclarationStepStatusEnum> {
  @override
  final int typeId = 21;

  @override
  DeclarationStepStatusEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DeclarationStepStatusEnum.inProcess;
      case 1:
        return DeclarationStepStatusEnum.expired;
      case 2:
        return DeclarationStepStatusEnum.completed;
      case 3:
        return DeclarationStepStatusEnum.completedWithComment;
      case 4:
        return DeclarationStepStatusEnum.declined;
      default:
        return DeclarationStepStatusEnum.inProcess;
    }
  }

  @override
  void write(BinaryWriter writer, DeclarationStepStatusEnum obj) {
    switch (obj) {
      case DeclarationStepStatusEnum.inProcess:
        writer.writeByte(0);
        break;
      case DeclarationStepStatusEnum.expired:
        writer.writeByte(1);
        break;
      case DeclarationStepStatusEnum.completed:
        writer.writeByte(2);
        break;
      case DeclarationStepStatusEnum.completedWithComment:
        writer.writeByte(3);
        break;
      case DeclarationStepStatusEnum.declined:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationStepStatusEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
