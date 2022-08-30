// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_info/task_parametr_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_parametr_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 26)
class TaskParametrModel extends TaskParametrEntity {
  @HiveField(0)
  final String title;
  
  @HiveField(1)
  final String value;

  const TaskParametrModel(this.title, this.value)
      : super(
          title: title,
          value: value,
        );

  factory TaskParametrModel.fromJson(Map<String, dynamic> json) =>
      _$TaskParametrModelFromJson(json);
}
