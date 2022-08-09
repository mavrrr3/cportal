// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/data/models/declarations/declaration_status_model.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'declaration_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 12)
class DeclarationModel extends DeclarationEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime date;
  @JsonKey(name: 'expires_date')
  @HiveField(4)
  final DateTime? expiresDate;
  @HiveField(5)
  final List<DeclarationStatusModel> statuses;

  DeclarationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.expiresDate,
    required this.statuses,
  }) : super(
          id: id,
          title: title,
          description: description,
          date: date,
          expiresDate: expiresDate,
          statuses: statuses,
        );

  factory DeclarationModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationModelFromJson(json);
}
