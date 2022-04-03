// Для парсинга JSON данных
//
// final userEntity = userEntityFromJson(jsonString);

import 'dart:convert';
import 'package:cportal_flutter/domain/entities/user_entity.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends UserEntity {
  const UserModel({
    required final String id,
    required final String userName,
    required final String profileId,
    required final DateTime lastLogin,
    required final bool blocked,
    required final DateTime dateCreated,
    required final String userCreated,
    required final DateTime? dateUpdated,
    required final String userUpdated,
    required final UserTypeModel userType,
  }) : super(
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

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        userName: json['user_name'],
        profileId: json['profile_id'],
        lastLogin: DateTime.parse(json['last_login']),
        blocked: json['blocked'],
        dateCreated: DateTime.parse(json['date_created']),
        userCreated: json['user_created'],
        dateUpdated: json['date_updated'],
        userUpdated: json['user_updated'],
        userType: UserTypeModel.fromJson(json['user_type']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_name': userName,
        'profile_id': profileId,
        'last_login': lastLogin.toIso8601String(),
        'blocked': blocked,
        'date_created': dateCreated.toIso8601String(),
        'user_created': userCreated,
        'date_updated': dateUpdated,
        'user_updated': userUpdated,
        'user_type': (userType as UserTypeModel).toRawJson(),
      };
}

class UserTypeModel extends UserTypeEntity {
  UserTypeModel({
    required final String id,
    required final String code,
    required final String description,
  }) : super(
          id: id,
          code: code,
          description: description,
        );

  factory UserTypeModel.fromRawJson(String str) =>
      UserTypeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserTypeModel.fromJson(Map<String, dynamic> json) => UserTypeModel(
        id: json['id'],
        code: json['code'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'description': description,
      };
}
