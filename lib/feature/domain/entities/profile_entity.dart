// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String externalId;
  final String firstName;
  final String lastName;
  final String middleName;
  final String birthday;
  final String email;
  final String photoLink;
  final bool active;
  final PositionEntity position;
  final List<PhoneEntity> phone;
  final String userCreated;
  final DateTime dateCreated;
  final String userUpdate;
  final DateTime dateUpdated;

  const ProfileEntity({
    required this.id,
    required this.externalId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.birthday,
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

  @override
  List<Object?> get props => [
        id,
        externalId,
        firstName,
        lastName,
        middleName,
        birthday,
        email,
        photoLink,
        active,
        position,
        phone,
        userCreated,
        dateCreated,
        userUpdate,
        dateUpdated,
      ];
}

class PhoneEntity extends Equatable {
  final String number;
  final String? suffix;
  final bool primary;

  const PhoneEntity({
    required this.number,
    required this.suffix,
    required this.primary,
  });

  @override
  List<Object?> get props => [number, suffix, primary];
}

class PositionEntity extends Equatable {
  final String id;
  final String description;
  final String department;

  const PositionEntity({
    required this.id,
    required this.description,
    required this.department,
  });

  @override
  List<Object?> get props => [id, description, department];
}
