// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'declaration_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeclarationEnumAdapter extends TypeAdapter<DeclarationEnum> {
  @override
  final int typeId = 19;

  @override
  DeclarationEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DeclarationEnum.def;
      case 1:
        return DeclarationEnum.task;
      case 2:
        return DeclarationEnum.documents;
      default:
        return DeclarationEnum.def;
    }
  }

  @override
  void write(BinaryWriter writer, DeclarationEnum obj) {
    switch (obj) {
      case DeclarationEnum.def:
        writer.writeByte(0);
        break;
      case DeclarationEnum.task:
        writer.writeByte(1);
        break;
      case DeclarationEnum.documents:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
