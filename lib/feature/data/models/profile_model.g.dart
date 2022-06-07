// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileModelAdapter extends TypeAdapter<ProfileModel> {
  @override
  final int typeId = 2;

  @override
  ProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileModel(
      id: fields[0] as String,
      fullName: fields[1] as String,
      department: fields[2] as String,
      position: fields[3] as String,
      birthday: fields[4] as DateTime,
      photoLink: fields[5] as String,
      phone: (fields[6] as List).cast<PhoneEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProfileModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.department)
      ..writeByte(3)
      ..write(obj.position)
      ..writeByte(4)
      ..write(obj.birthday)
      ..writeByte(5)
      ..write(obj.photoLink)
      ..writeByte(6)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PhoneModelAdapter extends TypeAdapter<PhoneModel> {
  @override
  final int typeId = 3;

  @override
  PhoneModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhoneModel(
      type: fields[0] as String,
      contact: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PhoneModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.contact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
