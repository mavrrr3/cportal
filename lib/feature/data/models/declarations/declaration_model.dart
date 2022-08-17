// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/data/models/declarations/description_enum.dart';
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
  @JsonKey(name: 'description_enum', defaultValue: DescriptionEnum.def)
  final DescriptionEnum descriptionEnum;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  final String status;
  DeclarationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.descriptionEnum,
  }) : super(
          id: id,
          title: title,
          description: description,
          descriptionEnum: descriptionEnum,
          date: date,
          status: status,
        );

  factory DeclarationModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationModelFromJson(json);
}
