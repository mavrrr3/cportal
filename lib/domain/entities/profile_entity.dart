// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

ProfileEntity profileFromJson(String str) =>
    ProfileEntity.fromJson(json.decode(str));

String profileToJson(ProfileEntity data) => json.encode(data.toJson());

class ProfileEntity {
  ProfileEntity({
    required this.id,
    required this.externalId,
    required this.firstName,
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
  });

  final String id;
  final String externalId;
  final String firstName;
  final String lastName;
  final String middleName;
  final String email;
  final String photoLink;
  final bool active;
  final Position position;
  final List<Phone> phone;
  final String userCreated;
  final DateTime dateCreated;
  final String userUpdate;
  final DateTime dateUpdated;

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
        id: json['id'],
        externalId: json['external_id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        middleName: json['middle_name'],
        email: json['email'],
        photoLink: json['photo_link'],
        active: json['active'],
        position: Position.fromJson(json['position']),
        phone: List<Phone>.from(json['phone'].map((x) => Phone.fromJson(x))),
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
        'phone': List<Phone>.from(phone.map((x) => x.toJson())),
        'user_created': userCreated,
        'date_created': dateCreated.toIso8601String(),
        'user_update': userUpdate,
        'date_updated': dateUpdated.toIso8601String(),
      };
}

class Phone {
  Phone({
    required this.number,
    required this.suffix,
    required this.primary,
  });

  final String number;
  final String suffix;
  final bool primary;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
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

class Position {
  Position({
    required this.id,
    required this.description,
  });

  final String id;
  final String description;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        id: json['id'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
      };
}
