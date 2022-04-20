// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
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
  final PositionEntity position;
  final List<PhoneEntity> phone;
  final String userCreated;
  final DateTime dateCreated;
  final String userUpdate;
  final DateTime dateUpdated;

  @override
  List<Object?> get props => [
        id,
        externalId,
        firstName,
        lastName,
        middleName,
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
  const PhoneEntity({
    required this.number,
    required this.suffix,
    required this.primary,
  });

  final String number;
  final String? suffix;
  final bool primary;

  @override
  List<Object?> get props => [number, suffix, primary];
}

class PositionEntity extends Equatable {
  const PositionEntity({
    required this.id,
    required this.description,
    required this.department,
  });

  final String id;
  final String description;
  final String department;

  @override
  List<Object?> get props => [id, description, department];
}
