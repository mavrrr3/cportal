// Для парсинга JSON данных
//
// final userEntity = userEntityFromJson(jsonString);

// ignore_for_file: annotate_overrides, overridden_fields

import 'dart:convert';
import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

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
    required this.id,
    required this.userName,
    required this.profileId,
    required this.lastLogin,
    required this.blocked,
    required this.dateCreated,
    required this.userCreated,
    required this.dateUpdated,
    required this.userUpdated,
    required this.userType,
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
        'user_type': userType.toRawJson(),
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
