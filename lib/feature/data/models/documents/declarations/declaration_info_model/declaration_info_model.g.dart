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
      date: fields[1] as DateTime,
      title: fields[2] as String,
      status: fields[3] as String,
      currentStep: fields[4] as int,
      allSteps: fields[5] as int,
      progressDescription: fields[6] as String,
      descriptionEnum: fields[7] as DescriptionEnum,
      priority: fields[8] as String,
      params: (fields[9] as List).cast<DeclarationDataModel>(),
      actions: (fields[10] as List).cast<DeclarationStepModel>(),
      documents: (fields[11] as List).cast<DeclarationDocumentModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationInfoModel obj) {
    writer
      ..writeByte(12)
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
      ..write(obj.allSteps)
      ..writeByte(6)
      ..write(obj.progressDescription)
      ..writeByte(7)
      ..write(obj.descriptionEnum)
      ..writeByte(8)
      ..write(obj.priority)
      ..writeByte(9)
      ..write(obj.params)
      ..writeByte(10)
      ..write(obj.actions)
      ..writeByte(11)
      ..write(obj.documents);
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
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      status: json['status'] as String,
      currentStep: json['current_step'] as int,
      allSteps: json['all_steps'] as int,
      progressDescription: json['description'] as String,
      descriptionEnum: $enumDecodeNullable(
              _$DescriptionEnumEnumMap, json['description_enum']) ??
          DescriptionEnum.def,
      priority: json['priority'] as String,
      params: (json['parameters'] as List<dynamic>?)
              ?.map((e) =>
                  DeclarationDataModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      actions: (json['actions'] as List<dynamic>?)
              ?.map((e) =>
                  DeclarationStepModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      documents: (json['documents'] as List<dynamic>)
          .map((e) =>
              DeclarationDocumentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

const _$DescriptionEnumEnumMap = {
  DescriptionEnum.def: 'Стандартный',
  DescriptionEnum.task: 'Задача',
  DescriptionEnum.expired: 'Истек срок',
};
