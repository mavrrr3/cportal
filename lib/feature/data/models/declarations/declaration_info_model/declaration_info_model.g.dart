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
      type: fields[2] as DeclarationEnum,
      date: fields[3] as DateTime,
      priority: fields[4] as String,
      progress: fields[5] as double,
      initiator: fields[6] as DeclarationUserModel,
      responsible: fields[7] as DeclarationUserModel,
      steps: (fields[8] as List).cast<DeclarationStepModel>(),
      documents: (fields[9] as List).cast<DeclarationDocumentModel>(),
      data: (fields[10] as List).cast<DeclarationDataModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationInfoModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.progress)
      ..writeByte(6)
      ..write(obj.initiator)
      ..writeByte(7)
      ..write(obj.responsible)
      ..writeByte(8)
      ..write(obj.steps)
      ..writeByte(9)
      ..write(obj.documents)
      ..writeByte(10)
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclarationInfoModel _$DeclarationInfoModelFromJson(
        Map<String, dynamic> json) =>
    DeclarationInfoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      type: $enumDecode(_$DeclarationEnumEnumMap, json['type']),
      date: DateTime.parse(json['date'] as String),
      priority: json['priority'] as String,
      progress: (json['progress'] as num).toDouble(),
      initiator: DeclarationUserModel.fromJson(
          json['initiator'] as Map<String, dynamic>),
      responsible: DeclarationUserModel.fromJson(
          json['responsible'] as Map<String, dynamic>),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => DeclarationStepModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      documents: (json['documents'] as List<dynamic>)
          .map((e) =>
              DeclarationDocumentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>)
          .map((e) => DeclarationDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

const _$DeclarationEnumEnumMap = {
  DeclarationEnum.def: 'Стандартный',
  DeclarationEnum.task: 'Стандартный',
  DeclarationEnum.documents: 'Стандартный',
};
