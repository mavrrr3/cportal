// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:convert';

import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:hive/hive.dart';

part 'profile_model.g.dart';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str) as Map<String, dynamic>);

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

PhoneModel phoneModelFromJson(String str) =>
    PhoneModel.fromJson(json.decode(str) as Map<String, dynamic>);

String phoneModelToJson(PhoneModel data) => json.encode(data.toJson());

@HiveType(typeId: 2)
class ProfileModel extends ProfileEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String department;

  @HiveField(3)
  final String position;

  @HiveField(4)
  final String photoLink;

  @HiveField(5)
  final DateTime? birthday;

  @HiveField(6)
  final List<PhoneModel> phone;

  const ProfileModel({
    required this.id,
    required this.fullName,
    required this.department,
    required this.position,
    required this.birthday,
    required this.photoLink,
    required this.phone,
  }) : super(
          id: id,
          fullName: fullName,
          department: department,
          position: position,
          birthday: birthday,
          photoLink: photoLink,
          phone: phone,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'] as String,
        fullName: json['name'] as String,
        department: json['departament'] as String,
        position: json['position'] as String,
        photoLink: json['photo'] as String,
        birthday: json['birthdate'] != null
            ? DateTime.parse(json['birthdate'] as String)
            : null,
        phone: json['contacts'] != null
            ? List<PhoneModel>.from(
                json['contacts'].map(
                  (dynamic x) => PhoneModel.fromJson(x as Map<String, dynamic>),
                ) as Iterable<dynamic>,
              )
            : [],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': fullName,
        'birthday': birthday,
        'photo_link': photoLink,
        'position': position,
        // 'phone': List<String>.from(
        //   phone.map(phoneModelToJson).toList(),
        // ),
      };
}

@HiveType(typeId: 3)
class PhoneModel extends PhoneEntity {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final String contact;

  const PhoneModel({
    required this.type,
    required this.contact,
  }) : super(
          type: type,
          contact: contact,
        );

  factory PhoneModel.fromJson(Map<String, dynamic> json) => PhoneModel(
        type: json['type'] as String,
        contact: json['contact'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'contact': contact,
      };
}
