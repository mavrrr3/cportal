// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileModelAdapter extends TypeAdapter<ProfileModel> {
  @override
  final int typeId = 1;

  @override
  ProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileModel(
      id: fields[0] as String,
      firstName: fields[1] as String,
      externalId: fields[2] as String,
      lastName: fields[3] as String,
      middleName: fields[4] as String,
      email: fields[5] as String,
      photoLink: fields[6] as String,
      active: fields[7] as bool,
      position: fields[8] as PositionModel,
      phone: (fields[9] as List).cast<PhoneModel>(),
      userCreated: fields[10] as String,
      dateCreated: fields[11] as DateTime,
      userUpdate: fields[12] as String,
      dateUpdated: fields[13] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.externalId)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.middleName)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.photoLink)
      ..writeByte(7)
      ..write(obj.active)
      ..writeByte(8)
      ..write(obj.position)
      ..writeByte(9)
      ..write(obj.phone)
      ..writeByte(10)
      ..write(obj.userCreated)
      ..writeByte(11)
      ..write(obj.dateCreated)
      ..writeByte(12)
      ..write(obj.userUpdate)
      ..writeByte(13)
      ..write(obj.dateUpdated);
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

class PositionModelAdapter extends TypeAdapter<PositionModel> {
  @override
  final int typeId = 2;

  @override
  PositionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionModel(
      id: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PositionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionModelAdapter &&
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
      number: fields[0] as String,
      suffix: fields[1] as String?,
      primary: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PhoneModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.suffix)
      ..writeByte(2)
      ..write(obj.primary);
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
