// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/data/models/documents/declarations/description_enum.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/task_info/task_action_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/task_info/task_document_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/task_info/task_parametr_model.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_info/task_info_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_info_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 23)
class TaskInfoModel extends TaskInfoEntity {
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

  @HiveField(6)
  final String description;

  @JsonKey(name: 'description_enum', defaultValue: DescriptionEnum.def)
  @HiveField(7)
  final DescriptionEnum descriptionEnum;

  @HiveField(8)
  final String content;

  @HiveField(9)
  final String priority;

  @JsonKey(name: 'initiator_name')
  @HiveField(10)
  final String initiatorName;

  @JsonKey(name: 'initiator_position')
  @HiveField(11)
  final String initiatorPosition;

  @JsonKey(name: 'initiator_image')
  @HiveField(12)
  final String initiatorImage;

  @JsonKey(defaultValue: <TaskDocumentModel>[])
  @HiveField(13)
  final List<TaskDocumentModel> documents;

  @JsonKey(name: 'parameters', defaultValue: <TaskParametrModel>[])
  @HiveField(14)
  final List<TaskParametrModel> parametrs;

  @JsonKey(defaultValue: <TaskActionModel>[])
  @HiveField(15)
  final List<TaskActionModel> actions;

  const TaskInfoModel({
    required this.id,
    required this.date,
    required this.title,
    required this.status,
    required this.currentStep,
    required this.allSteps,
    required this.description,
    required this.descriptionEnum,
    required this.content,
    required this.priority,
    required this.initiatorName,
    required this.initiatorPosition,
    required this.initiatorImage,
    required this.documents,
    required this.parametrs,
    required this.actions,
  }) : super(
          id: id,
          date: date,
          title: title,
          status: status,
          currentStep: currentStep,
          allSteps: allSteps,
          description: description,
          descriptionEnum: descriptionEnum,
          content: content,
          priority: priority,
          initiatorName: initiatorName,
          initiatorPosition: initiatorPosition,
          initiatorImage: initiatorImage,
          documents: documents,
          parametrs: parametrs,
          actions: actions,
        );

  factory TaskInfoModel.fromJson(Map<String, dynamic> json) =>
      _$TaskInfoModelFromJson(json);
}
