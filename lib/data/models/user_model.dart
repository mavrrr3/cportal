import 'package:cportal_flutter/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String username,
    required String position,
    required String image,
    required String department,
    required String email,
    required String internalPhone,
    required String externalPhone,
  }) : super(
          id: id,
          username: username,
          position: position,
          image: image,
          department: department,
          email: email,
          internalPhone: internalPhone,
          externalPhone: externalPhone,
        );
}
