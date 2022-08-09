// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_status_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'declaration_status_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 18)
class DeclarationStatusModel extends DeclarationStatusEntity {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String color;

  const DeclarationStatusModel({
    required this.title,
    required this.color,
  }) : super(
          title: title,
          color: color,
        );

  factory DeclarationStatusModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationStatusModelFromJson(json);
}
