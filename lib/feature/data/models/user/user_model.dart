// ignore_for_file: annotate_overrides, overridden_fields

import 'package:cportal_flutter/feature/data/models/user/contact_model.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 0)
class UserModel extends UserEntity {
  @HiveField(0)
  final String token;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  @JsonKey(name: 'departament')
  @HiveField(4)
  final String department;
  @HiveField(5)
  final String position;
  @JsonKey(name: 'birthdate')
  @HiveField(6)
  final DateTime birthDate;
  @HiveField(7)
  final List<ContactModel> contacts;
  @JsonKey(name: 'photo')
  @HiveField(8)
  final String photoUrl;

  const UserModel({
    required this.token,
    required this.id,
    required this.name,
    required this.department,
    required this.position,
    required this.birthDate,
    required this.contacts,
    required this.photoUrl,
  }) : super(
          id: id,
          name: name,
          department: department,
          position: position,
          birthDate: birthDate,
          contacts: contacts,
          photoUrl: photoUrl,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
