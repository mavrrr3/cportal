import 'package:cportal_flutter/domain/entities/profile_entity.dart';
import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

class ProfileHiveAdapter extends TypeAdapter<ProfileEntity> {
  @override
  final typeId = 1;

  @override
  ProfileEntity read(BinaryReader reader) {
    final String id = reader.readString();
    final String externalId = reader.readString();
    final String firstName = reader.readString();
    final String lastName = reader.readString();
    final String middleName = reader.readString();
    final String email = reader.readString();
    final String photoLink = reader.readString();
    final bool active = reader.readBool();
    final PositionEntity position = reader.read();
    final List<PhoneEntity> phone = reader.read();
    final String userCreated = reader.readString();
    final DateTime dateCreated = reader.read();
    final String userUpdate = reader.readString();
    final DateTime dateUpdated = reader.read();

    return ProfileEntity(
      id: id,
      externalId: externalId,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      email: email,
      photoLink: photoLink,
      active: active,
      position: position,
      phone: phone,
      userCreated: userCreated,
      dateCreated: dateCreated,
      userUpdate: userUpdate,
      dateUpdated: dateUpdated,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileEntity obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.externalId);
    writer.writeString(obj.firstName);
    writer.writeString(obj.lastName);
    writer.writeString(obj.middleName);
    writer.writeString(obj.email);
    writer.writeString(obj.photoLink);
    writer.writeBool(obj.active);
    writer.write(obj.position);
    writer.write(obj.phone);
    writer.writeString(obj.userCreated);
    writer.writeString(obj.userUpdate);
    writer.write(obj.dateCreated);
    writer.write(obj.dateUpdated);
  }
}

class PositionHiveAdapter extends TypeAdapter<PositionEntity> {
  @override
  final typeId = 2;

  @override
  PositionEntity read(BinaryReader reader) {
    final String id = reader.readString();
    final String description = reader.readString();

    return PositionEntity(
      id: id,
      description: description,
    );
  }

  @override
  void write(BinaryWriter writer, PositionEntity obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.description);
  }
}

class PhoneHiveAdapter extends TypeAdapter<PhoneEntity> {
  @override
  final typeId = 3;

  @override
  PhoneEntity read(BinaryReader reader) {
    final String number = reader.readString();
    final String? suffix = reader.read();
    final bool primary = reader.readBool();

    return PhoneEntity(
      number: number,
      suffix: suffix ?? '',
      primary: primary,
    );
  }

  @override
  void write(BinaryWriter writer, PhoneEntity obj) {
    writer.writeString(obj.number);
    writer.write(obj.suffix);
    writer.writeBool(obj.primary);
  }
}
