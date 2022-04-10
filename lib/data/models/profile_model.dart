// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:cportal_flutter/domain/entities/profile_entity.dart';
import 'package:hive/hive.dart';

part 'profile_model.g.dart';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

PhoneModel phoneModelFromJson(String str) =>
    PhoneModel.fromJson(json.decode(str));

@HiveType(typeId: 2)
class ProfileModel extends ProfileEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String externalId;

  @HiveField(3)
  final String lastName;

  @HiveField(4)
  final String middleName;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final String photoLink;

  @HiveField(7)
  final bool active;

  @HiveField(8)
  final PositionModel position;

  @HiveField(9)
  final List<PhoneModel> phone;

  @HiveField(10)
  final String userCreated;

  @HiveField(11)
  final DateTime dateCreated;

  @HiveField(12)
  final String userUpdate;

  @HiveField(13)
  final DateTime dateUpdated;

  const ProfileModel({
    required this.id,
    required this.firstName,
    required this.externalId,
    required this.lastName,
    required this.middleName,
    required this.email,
    required this.photoLink,
    required this.active,
    required this.position,
    required this.phone,
    required this.userCreated,
    required this.dateCreated,
    required this.userUpdate,
    required this.dateUpdated,
  }) : super(
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'],
        externalId: json['external_id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        middleName: json['middle_name'],
        email: json['email'],
        photoLink: json['photo_link'],
        active: json['active'],
        position: PositionModel.fromJson(json['position']),
        phone: List<PhoneModel>.from(
          json['phone'].map((x) => PhoneModel.fromJson(x)),
        ),
        userCreated: json['user_created'],
        dateCreated: DateTime.parse(json['date_created']),
        userUpdate: json['user_update'],
        dateUpdated: DateTime.parse(json['date_updated']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'external_id': externalId,
        'first_name': firstName,
        'last_name': lastName,
        'middle_name': middleName,
        'email': email,
        'photo_link': photoLink,
        'active': active,
        'position': position.toJson(),
        'phone': List<PhoneModel>.from(
          phone.map((x) => x.toJson()),
        ),
        'user_created': userCreated,
        'date_created': dateCreated.toIso8601String(),
        'user_update': userUpdate,
        'date_updated': dateUpdated.toIso8601String(),
      };
}

@HiveType(typeId: 3)
class PositionModel extends PositionEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String description;

  const PositionModel({
    required this.id,
    required this.description,
  }) : super(id: id, description: description);

  factory PositionModel.fromJson(Map<String, dynamic> json) => PositionModel(
        id: json['id'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
      };
}

@HiveType(typeId: 4)
class PhoneModel extends PhoneEntity {
  @HiveField(0)
  final String number;
  @HiveField(1)
  final String? suffix;
  @HiveField(2)
  final bool primary;

  const PhoneModel({
    required this.number,
    required this.suffix,
    required this.primary,
  }) : super(
          number: number,
          suffix: suffix ?? '',
          primary: primary,
        );

  factory PhoneModel.fromJson(Map<String, dynamic> json) => PhoneModel(
        number: json['number'],
        suffix: json['suffix'],
        primary: json['primary'],
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'suffix': suffix,
        'primary': primary,
      };
}
