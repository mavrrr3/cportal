// ignore_for_file: annotate_overrides, overridden_fields

import 'package:cportal_flutter/feature/data/models/documents/tasks/task_card_model.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/tasks_response_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tasks_response_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 27)
class TasksResponseModel extends TasksResponseEntity {
  @HiveField(0)
  final int total;

  @HiveField(1)
  final List<TaskCardModel> items;

  const TasksResponseModel({
    required this.total,
    required this.items,
  }) : super(total: total, items: items);

  factory TasksResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TasksResponseModelFromJson(json);
}
