// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'new_employee_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewEmployeeModelAdapter extends TypeAdapter<NewEmployeeModel> {
  @override
  final int typeId = 19;

  @override
  NewEmployeeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewEmployeeModel(
      title: fields[0] as String,
      description: fields[1] as String,
      image: fields[2] as String,
      isVector: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NewEmployeeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.isVector);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewEmployeeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
