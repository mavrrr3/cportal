// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OnboardingModelAdapter extends TypeAdapter<OnboardingModel> {
  @override
  final int typeId = 11;

  @override
  OnboardingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OnboardingModel(
      onboardingDuration: fields[0] as int,
      learningCourseDuration: fields[1] as int,
      pages: (fields[2] as List).cast<OnboardingItemModel>(),
      course: fields[3] as OnboardingItemModel,
    );
  }

  @override
  void write(BinaryWriter writer, OnboardingModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.onboardingDuration)
      ..writeByte(1)
      ..write(obj.learningCourseDuration)
      ..writeByte(2)
      ..write(obj.pages)
      ..writeByte(3)
      ..write(obj.course);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OnboardingItemModelAdapter extends TypeAdapter<OnboardingItemModel> {
  @override
  final int typeId = 12;

  @override
  OnboardingItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OnboardingItemModel(
      header: fields[0] as String,
      description: fields[1] as String,
      image: fields[2] as String,
      isVector: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, OnboardingItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.header)
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
      other is OnboardingItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
