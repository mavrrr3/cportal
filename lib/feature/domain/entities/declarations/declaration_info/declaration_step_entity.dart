import 'package:cportal_flutter/feature/data/models/declarations/task_status_enum.dart';

class DeclarationStepEntity {
  final String id;
  final DateTime date;
  final String responsibleName;
  final String responsiblePosition;
  final String responsibleImage;
  final String description;
  final TaskStatusEnum status;
  final DateTime descriptionDate;
  final String comment;

  DeclarationStepEntity({
    required this.id,
    required this.date,
    required this.responsibleName,
    required this.responsiblePosition,
    required this.responsibleImage,
    required this.description,
    required this.status,
    required this.descriptionDate,
    required this.comment,
  });
}
