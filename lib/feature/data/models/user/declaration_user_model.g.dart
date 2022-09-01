// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'declaration_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeclarationUserModelAdapter extends TypeAdapter<DeclarationUserModel> {
  @override
  final int typeId = 14;

  @override
  DeclarationUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeclarationUserModel(
      id: fields[0] as String,
      fullName: fields[1] as String,
      position: fields[2] as String,
      image: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationUserModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.position)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
