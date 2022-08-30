// ignore_for_file: annotate_overrides, overridden_fields

import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/task_status_enum.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_info/task_action_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_action_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 25)
class TaskActionModel extends TaskActionEntity {
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
  final String description;

  @JsonKey(
    name: 'description_enum',
    defaultValue: TaskStatusEnum.inProccess,
  )
  @HiveField(6)
  final TaskStatusEnum status;

  @JsonKey(name: 'description_date')
  @HiveField(7)
  final DateTime descriptionDate;

  @HiveField(8)
  final String comment;

  const TaskActionModel({
    required this.id,
    required this.date,
    required this.responsibleName,
    required this.responsiblePosition,
    required this.responsibleImage,
    required this.description,
    required this.status,
    required this.descriptionDate,
    required this.comment,
  }) : super(
          id: id,
          date: date,
          responsibleName: responsibleName,
          responsiblePosition: responsiblePosition,
          responsibleImage: responsibleImage,
          description: description,
          status: status,
          descriptionDate: descriptionDate,
          comment: comment,
        );

  factory TaskActionModel.fromJson(Map<String, dynamic> json) =>
      _$TaskActionModelFromJson(json);
}
