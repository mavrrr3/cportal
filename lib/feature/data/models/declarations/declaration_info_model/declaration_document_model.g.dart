// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'declaration_document_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeclarationDocumentModelAdapter
    extends TypeAdapter<DeclarationDocumentModel> {
  @override
  final int typeId = 20;

  @override
  DeclarationDocumentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeclarationDocumentModel(
      title: fields[0] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeclarationDocumentModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeclarationDocumentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclarationDocumentModel _$DeclarationDocumentModelFromJson(
        Map<String, dynamic> json) =>
    DeclarationDocumentModel(
      title: json['title'] as String,
      url: json['url'] as String,
    );
