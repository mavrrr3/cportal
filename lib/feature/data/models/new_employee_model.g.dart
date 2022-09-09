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
    );
  }

  @override
  void write(BinaryWriter writer, NewEmployeeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.image);
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

class NewEmployeeResponseModelAdapter
    extends TypeAdapter<NewEmployeeResponseModel> {
  @override
  final int typeId = 20;

  @override
  NewEmployeeResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewEmployeeResponseModel(
      count: fields[0] as int,
      slides: (fields[1] as List).cast<NewEmployeeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, NewEmployeeResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.slides);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewEmployeeResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
