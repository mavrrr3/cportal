// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleModelAdapter extends TypeAdapter<ArticleModel> {
  @override
  final int typeId = 5;

  @override
  ArticleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleModel(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      category: fields[2] as String,
      header: fields[3] as String,
      content: (fields[4] as List).cast<ParagraphModel>(),
      image: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.header)
      ..writeByte(4)
      ..write(obj.content)
      ..writeByte(5)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ParagraphModelAdapter extends TypeAdapter<ParagraphModel> {
  @override
  final int typeId = 6;

  @override
  ParagraphModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParagraphModel(
      template: fields[0] as String,
      content: fields[1] as String?,
      imageTitle: fields[2] as String?,
      image: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ParagraphModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.template)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.imageTitle)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParagraphModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
