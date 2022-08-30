// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_info/task_document_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_document_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 24)
class TaskDocumentModel extends TaskDocumentEntity {
  @HiveField(0)
  final String title;
  
  @HiveField(1)
  final String file;

  const TaskDocumentModel(this.title, this.file)
      : super(title: title, file: file);
  factory TaskDocumentModel.fromJson(Map<String, dynamic> json) =>
      _$TaskDocumentModelFromJson(json);
}
