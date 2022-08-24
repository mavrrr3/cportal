// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_step_status_enum.dart';
import 'package:cportal_flutter/feature/data/models/declarations/description_enum.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_step_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'declaration_step_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 17)
class DeclarationStepModel extends DeclarationStepEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @JsonKey(name: 'responsible_name')
  @HiveField(2)
  final String responsibleName;

  @JsonKey(name: 'responsible_position')
  @HiveField(3)
  final String responsiblePosition;

  @JsonKey(name: 'responsible_image')
  @HiveField(4)
  final String responsibleImage;

  @HiveField(5)
  @JsonKey(defaultValue: DeclarationStepStatusEnum.inProcess)
  final DeclarationStepStatusEnum status;

  @HiveField(6)
  final String description;

  @JsonKey(name: 'description_enum')
  @HiveField(7)
  final DescriptionEnum descrtiptionEnum;

  @JsonKey(name: 'expires_date')
  @HiveField(8)
  final DateTime expiresDate;

  DeclarationStepModel({
    required this.id,
    required this.date,
    required this.responsibleName,
    required this.responsiblePosition,
    required this.responsibleImage,
    required this.status,
    required this.description,
    required this.descrtiptionEnum,
    required this.expiresDate,
  }) : super(
          id: id,
          date: date,
          responsibleName: responsibleName,
          responsiblePosition: responsiblePosition,
          responsibleImage: responsibleImage,
          status: status,
          description: description,
          descrtiptionEnum: descrtiptionEnum,
          expiresDate: expiresDate,
        );

  factory DeclarationStepModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationStepModelFromJson(json);
}
