// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterModelAdapter extends TypeAdapter<FilterModel> {
  @override
  final int typeId = 7;

  @override
  FilterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterModel(
      headline: fields[0] as String,
      items: (fields[2] as List).cast<FilterItemModel>(),
      isActive: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FilterModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.headline)
      ..writeByte(1)
      ..write(obj.isActive)
      ..writeByte(2)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FilterItemModelAdapter extends TypeAdapter<FilterItemModel> {
  @override
  final int typeId = 8;

  @override
  FilterItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterItemModel(
      name: fields[0] as String,
      isActive: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FilterItemModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FilterResponseModelAdapter extends TypeAdapter<FilterResponseModel> {
  @override
  final int typeId = 11;

  @override
  FilterResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterResponseModel(
      filters: (fields[0] as List).cast<FilterModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, FilterResponseModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.filters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
