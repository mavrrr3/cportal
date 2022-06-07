// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String fullName;
  final String department;
  final String position;
  final DateTime? birthday;
  final String photoLink;
  final List<PhoneEntity> phone;

  const ProfileEntity({
    required this.id,
    required this.fullName,
    required this.department,
    required this.position,
    required this.birthday,
    required this.photoLink,
    required this.phone,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        birthday,
        photoLink,
        position,
        phone,
      ];
}

class PhoneEntity extends Equatable {
  final String type;
  final String contact;

  const PhoneEntity({
    required this.type,
    required this.contact,
  });

  @override
  List<Object?> get props => [type, contact];
}
