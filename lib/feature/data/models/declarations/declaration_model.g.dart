// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'declaration_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeclarationModelAdapter extends TypeAdapter<DeclarationModel> {
  @override
  final int typeId = 12;

  @override
  DeclarationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeclarationModel(
      title: fields[2] as String,
      icon: fields[5] as String,
      date: fields[1] as DateTime,
      id: fields[0] as String,
      status: fields[3] as String,
      currentStep: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationModel obj) {
    writer
      ..writeByte(6)
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
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
