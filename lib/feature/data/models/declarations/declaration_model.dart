// ignore_for_file: overridden_fields, annotate_overrides

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
  @JsonKey(name: 'decription')
  final String description;
  @HiveField(3)
  @JsonKey(name: 'is_allert', defaultValue: false)
  final bool isAllert;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  @JsonKey(name: 'expires_date')
  final DateTime? expiresDate;
  @HiveField(6)
  final String status;
  @HiveField(7)
  @JsonKey(name: 'status_color')
  final String statusColor;

  DeclarationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.isAllert,
    this.expiresDate,
  }) : super(
          id: id,
          title: title,
          description: description,
          isAllert: isAllert,
          date: date,
          expiresDate: expiresDate,
          status: status,
          statusColor: statusColor,
        );

  factory DeclarationModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationModelFromJson(json);
}
