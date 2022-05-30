// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactsModelAdapter extends TypeAdapter<ContactsModel> {
  @override
  final int typeId = 10;

  @override
  ContactsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactsModel(
      contacts: (fields[1] as List).cast<ProfileModel>(),
      favorites: (fields[0] as List).cast<ProfileModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ContactsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.favorites)
      ..writeByte(1)
      ..write(obj.contacts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
