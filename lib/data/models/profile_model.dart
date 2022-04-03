import 'dart:convert';

import 'package:cportal_flutter/domain/entities/profile_entity.dart';

ProfileModel profileFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required final String id,
    required final String externalId,
    required final String firstName,
    required final String lastName,
    required final String middleName,
    required final String email,
    required final String photoLink,
    required final bool active,
    required final PositionEntity position,
    required final List<PhoneEntity> phone,
    required final String userCreated,
    required final DateTime dateCreated,
    required final String userUpdate,
    required final DateTime dateUpdated,
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
        'position': (position as PositionModel).toJson(),
        'phone': List<PhoneModel>.from(
          (phone as List<PhoneModel>).map((x) => x.toJson()),
        ),
        'user_created': userCreated,
        'date_created': dateCreated.toIso8601String(),
        'user_update': userUpdate,
        'date_updated': dateUpdated.toIso8601String(),
      };
}

class PhoneModel extends PhoneEntity {
  const PhoneModel({
    required String number,
    required String suffix,
    required bool primary,
  }) : super(
          number: number,
          suffix: suffix,
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

class PositionModel extends PositionEntity {
  const PositionModel({
    required String id,
    required String description,
  }) : super(
          id: id,
          description: description,
        );

  factory PositionModel.fromJson(Map<String, dynamic> json) => PositionModel(
        id: json['id'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
      };
}
