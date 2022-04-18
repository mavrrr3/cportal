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
      articleType: fields[1] as ArticleTypeEntity,
      header: fields[2] as String,
      category: fields[12] as String,
      description: fields[3] as String,
      image: fields[4] as String,
      dateShow: fields[5] as DateTime,
      externalLink: fields[6] as String,
      show: fields[7] as bool,
      userCreated: fields[8] as String,
      dateCreated: fields[9] as DateTime,
      userUpdate: fields[10] as String,
      dateUpdated: fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.articleType)
      ..writeByte(2)
      ..write(obj.header)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.dateShow)
      ..writeByte(6)
      ..write(obj.externalLink)
      ..writeByte(7)
      ..write(obj.show)
      ..writeByte(8)
      ..write(obj.userCreated)
      ..writeByte(9)
      ..write(obj.dateCreated)
      ..writeByte(10)
      ..write(obj.userUpdate)
      ..writeByte(11)
      ..write(obj.dateUpdated)
      ..writeByte(12)
      ..write(obj.category);
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

class ArticleTypeModelAdapter extends TypeAdapter<ArticleTypeModel> {
  @override
  final int typeId = 6;

  @override
  ArticleTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleTypeModel(
      id: fields[0] as String,
      code: fields[1] as String,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleTypeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
