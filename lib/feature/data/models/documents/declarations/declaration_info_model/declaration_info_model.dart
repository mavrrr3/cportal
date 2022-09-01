// ignore_for_file: overridden_fields, override_on_non_overriding_member, annotate_overrides

import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/declaration_data_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/declaration_document_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/declaration_step_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/description_enum.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_info_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'declaration_info_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 16)
class DeclarationInfoModel extends DeclarationInfoEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String status;

  @JsonKey(name: 'current_step')
  @HiveField(4)
  final int currentStep;

  @JsonKey(name: 'all_steps')
  @HiveField(5)
  final int allSteps;

  @JsonKey(name: 'description')
  @HiveField(6)
  final String progressDescription;

  @JsonKey(name: 'description_enum', defaultValue: DescriptionEnum.def)
  @HiveField(7)
  final DescriptionEnum descriptionEnum;

  @HiveField(8)
  final String priority;

  @HiveField(9)
  final String? content;

  @JsonKey(name: 'initiator_name')
  @HiveField(10)
  final String? initiatorName;

  @JsonKey(name: 'initiator_position')
  @HiveField(11)
  final String? initiatorPosition;

  @JsonKey(name: 'initiator_image')
  @HiveField(12)
  final String? initiatorImage;

  @JsonKey(name: 'parameters', defaultValue: <DeclarationDataModel>[])
  @HiveField(13)
  final List<DeclarationDataModel> params;

  @JsonKey(defaultValue: <DeclarationStepModel>[])
  @HiveField(14)
  final List<DeclarationStepModel> actions;

  @HiveField(15)
  final List<DeclarationDocumentModel> documents;

  const DeclarationInfoModel({
    required this.id,
    required this.date,
    required this.title,
    required this.status,
    required this.currentStep,
    required this.allSteps,
    required this.progressDescription,
    required this.descriptionEnum,
    required this.priority,
    required this.content,
    required this.initiatorName,
    required this.initiatorPosition,
    required this.initiatorImage,
    required this.params,
    required this.actions,
    required this.documents,
  }) : super(
          id: id,
          date: date,
          title: title,
          status: status,
          currentStep: currentStep,
          allSteps: allSteps,
          progressDescription: progressDescription,
          descriptionEnum: descriptionEnum,
          priority: priority,
          content: content,
          initiatorName: initiatorName,
          initiatorImage: initiatorImage,
          initiatorPosition: initiatorPosition,
          params: params,
          actions: actions,
          documents: documents,
        );

  factory DeclarationInfoModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationInfoModelFromJson(json);
}
