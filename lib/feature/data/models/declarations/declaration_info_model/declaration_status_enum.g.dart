// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'declaration_status_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeclarationStatusEnumAdapter extends TypeAdapter<DeclarationStatusEnum> {
  @override
  final int typeId = 21;

  @override
  DeclarationStatusEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DeclarationStatusEnum.done;
      case 1:
        return DeclarationStatusEnum.inProcess;
      case 2:
        return DeclarationStatusEnum.declined;
      default:
        return DeclarationStatusEnum.done;
    }
  }

  @override
  void write(BinaryWriter writer, DeclarationStatusEnum obj) {
    switch (obj) {
      case DeclarationStatusEnum.done:
        writer.writeByte(0);
        break;
      case DeclarationStatusEnum.inProcess:
        writer.writeByte(1);
        break;
      case DeclarationStatusEnum.declined:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationStatusEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
