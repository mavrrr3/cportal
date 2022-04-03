import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserHiveAdapter extends TypeAdapter<UserEntity> {
  @override
  final typeId = 1;

  @override
  UserEntity read(BinaryReader reader) {
    final String id = reader.readString();
    final String userName = reader.readString();
    final String profileId = reader.readString();
    final DateTime lastLogin = reader.read();
    final bool blocked = reader.readBool();
    final DateTime dateCreated = reader.read();
    final String userCreated = reader.readString();
    final DateTime dateUpdated = reader.read();
    final String userUpdated = reader.readString();
    final UserTypeEntity userType = reader.read();

    return UserEntity(
      id: id,
      userName: userName,
      profileId: profileId,
      lastLogin: lastLogin,
      blocked: blocked,
      dateCreated: dateCreated,
      userCreated: userCreated,
      dateUpdated: dateUpdated,
      userUpdated: userUpdated,
      userType: userType,
    );
  }

  @override
  void write(BinaryWriter writer, UserEntity obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.userName);
    writer.writeString(obj.profileId);
    writer.write(obj.lastLogin);
    writer.writeBool(obj.blocked);
    writer.write(obj.dateCreated);
    writer.writeString(obj.userCreated);
    writer.write(obj.dateUpdated);
    writer.writeString(obj.userUpdated);
    writer.write(obj.userType);
  }
}
