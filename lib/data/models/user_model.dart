// Для парсинга JSON данных
//
// final userEntity = userEntityFromJson(jsonString);

// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';
import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str) as Map<String, dynamic>);

String userModelToJson(UserModel data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class UserModel extends UserEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userName;

  @HiveField(2)
  final String profileId;

  @HiveField(3)
  final DateTime lastLogin;

  @HiveField(4)
  final bool blocked;

  @HiveField(5)
  final DateTime dateCreated;

  @HiveField(6)
  final String userCreated;

  @HiveField(7)
  final DateTime? dateUpdated;

  @HiveField(8)
  final String userUpdated;

  @HiveField(9)
  final UserTypeModel userType;

  const UserModel({
    required final this.id,
    required final this.userName,
    required final this.profileId,
    required final this.lastLogin,
    required final this.blocked,
    required final this.dateCreated,
    required final this.userCreated,
    required final this.dateUpdated,
    required final this.userUpdated,
    required final this.userType,
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
        id: json['id'] as String,
        userName: json['user_name'] as String,
        profileId: json['profile_id'] as String,
        lastLogin: DateTime.parse(json['last_login'] as String),
        blocked: json['blocked'] as bool,
        dateCreated: DateTime.parse(json['date_created'] as String),
        userCreated: json['user_created'] as String,
        dateUpdated: DateTime.parse(json['date_updated'] as String),
        userUpdated: json['user_updated'] as String,
        userType:
            UserTypeModel.fromJson(json['user_type'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'user_name': userName,
        'profile_id': profileId,
        'last_login': lastLogin.toIso8601String(),
        'blocked': blocked,
        'date_created': dateCreated.toIso8601String(),
        'user_created': userCreated,
        'date_updated': dateUpdated,
        'user_updated': userUpdated,
        'user_type': userType.toRawJson(),
      };
}

@HiveType(typeId: 1)
class UserTypeModel extends UserTypeEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String code;
  @HiveField(2)
  final String description;

  UserTypeModel({
    required final this.id,
    required final this.code,
    required final this.description,
  }) : super(
          id: id,
          code: code,
          description: description,
        );

  factory UserTypeModel.fromRawJson(String str) =>
      UserTypeModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory UserTypeModel.fromJson(Map<String, dynamic> json) => UserTypeModel(
        id: json['id'] as String,
        code: json['code'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'code': code,
        'description': description,
      };
}
