// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_status_enum.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_step_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'declaration_step_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 17)
class DeclarationStepModel extends DeclarationStepEntity {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final DeclarationStatusEnum status;

  DeclarationStepModel({
    required this.title,
    required this.date,
    required this.status,
  }) : super(title: title, date: date, status: status);

  factory DeclarationStepModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationStepModelFromJson(json);

}
