// ignore_for_file: overridden_fields, override_on_non_overriding_member, annotate_overrides

import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_data_model.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_document_model.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_enum.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_step_model.dart';
import 'package:cportal_flutter/feature/data/models/user/declaration_user_model.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_info_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'declaration_info_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 16)
class DeclarationInfoModel extends DeclarationInfoEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DeclarationEnum type;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String priority;

  @HiveField(5)
  final double progress;

  @HiveField(6)
  final DeclarationUserModel initiator;

  @HiveField(7)
  final DeclarationUserModel responsible;

  @HiveField(8)
  final List<DeclarationStepModel> steps;

  @HiveField(9)
  final List<DeclarationDocumentModel> documents;

  @HiveField(10)
  final List<DeclarationDataModel> data;

  DeclarationInfoModel({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
    required this.priority,
    required this.progress,
    required this.initiator,
    required this.responsible,
    required this.steps,
    required this.documents,
    required this.data,
  }) : super(
          id: id,
          title: title,
          type: type,
          date: date,
          priority: priority,
          progress: progress,
          initiator: initiator,
          responsible: responsible,
          steps: steps,
          documents: documents,
          data: data,
        );

        factory DeclarationInfoModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationInfoModelFromJson(json);

}
