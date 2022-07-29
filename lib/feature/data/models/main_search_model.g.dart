// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'main_search_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainSearchModelAdapter extends TypeAdapter<MainSearchModel> {
  @override
  final int typeId = 16;

  @override
  MainSearchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainSearchModel(
      category: fields[0] as String,
      id: fields[1] as String,
      title: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MainSearchModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainSearchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
