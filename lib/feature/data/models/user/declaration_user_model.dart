// ignore_for_file: overridden_fields

import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_user_entity.dart';
import 'package:hive/hive.dart';

part 'declaration_user_model.g.dart';

@HiveType(typeId: 14)
class DeclarationUserModel extends DeclarationUserEntity {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String fullName;

  @override
  @HiveField(2)
  final String position;

  @override
  @HiveField(3)
  final String image;

  DeclarationUserModel({
    required this.id,
    required this.fullName,
    required this.position,
    required this.image,
  }) : super(
          id: id,
          fullName: fullName,
          position: position,
          image: image,
        );

  factory DeclarationUserModel.fromJson(Map<String, dynamic> json) =>
      DeclarationUserModel(
        fullName: json['name'] as String,
        id: json['id'] as String,
        position: json['position'] as String,
        image: json['image'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': fullName,
        'id': id,
        'position': position,
        'image': image,
      };
}
