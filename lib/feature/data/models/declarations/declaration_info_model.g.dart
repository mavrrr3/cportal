// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'declaration_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeclarationInfoModelAdapter extends TypeAdapter<DeclarationInfoModel> {
  @override
  final int typeId = 16;

  @override
  DeclarationInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeclarationInfoModel(
      id: fields[0] as String,
      title: fields[1] as String,
      progress: fields[2] as double,
      status: fields[3] as String,
      priority: fields[4] as String,
      initiator: fields[5] as DeclarationUserModel,
      responsible: fields[6] as DeclarationUserModel,
      steps: (fields[7] as List).cast<DeclarationStepModel>(),
      data: (fields[8] as List).cast<DeclarationDataModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationInfoModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.progress)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.initiator)
      ..writeByte(6)
      ..write(obj.responsible)
      ..writeByte(7)
      ..write(obj.steps)
      ..writeByte(8)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeclarationStepModelAdapter extends TypeAdapter<DeclarationStepModel> {
  @override
  final int typeId = 17;

  @override
  DeclarationStepModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeclarationStepModel(
      title: fields[0] as String,
      date: fields[1] as DateTime,
      status: fields[2] as DeclarationStatusEnum,
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationStepModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationStepModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DeclarationDataModelAdapter extends TypeAdapter<DeclarationDataModel> {
  @override
  final int typeId = 16;

  @override
  DeclarationDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeclarationDataModel(
      title: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationDataModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
