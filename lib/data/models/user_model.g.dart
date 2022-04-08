// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      userName: fields[1] as String,
      profileId: fields[2] as String,
      lastLogin: fields[3] as DateTime,
      blocked: fields[4] as bool,
      dateCreated: fields[5] as DateTime,
      userCreated: fields[6] as String,
      dateUpdated: fields[7] as DateTime?,
      userUpdated: fields[8] as String,
      userType: fields[9] as UserTypeModel,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.profileId)
      ..writeByte(3)
      ..write(obj.lastLogin)
      ..writeByte(4)
      ..write(obj.blocked)
      ..writeByte(5)
      ..write(obj.dateCreated)
      ..writeByte(6)
      ..write(obj.userCreated)
      ..writeByte(7)
      ..write(obj.dateUpdated)
      ..writeByte(8)
      ..write(obj.userUpdated)
      ..writeByte(9)
      ..write(obj.userType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
