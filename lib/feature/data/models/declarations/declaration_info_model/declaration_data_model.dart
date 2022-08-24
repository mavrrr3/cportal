// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_data_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'declaration_data_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 16)
class DeclarationDataModel extends DeclarationDataEntity {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String value;

  DeclarationDataModel({
    required this.title,
    required this.value,
  }) : super(
          title: title,
          value: value,
        );

  factory DeclarationDataModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationDataModelFromJson(json);
}
