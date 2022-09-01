// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'description_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DescriptionEnumAdapter extends TypeAdapter<DescriptionEnum> {
  @override
  final int typeId = 18;

  @override
  DescriptionEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DescriptionEnum.def;
      case 1:
        return DescriptionEnum.task;
      case 2:
        return DescriptionEnum.expired;
      default:
        return DescriptionEnum.def;
    }
  }

  @override
  void write(BinaryWriter writer, DescriptionEnum obj) {
    switch (obj) {
      case DescriptionEnum.def:
        writer.writeByte(0);
        break;
      case DescriptionEnum.task:
        writer.writeByte(1);
        break;
      case DescriptionEnum.expired:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DescriptionEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
