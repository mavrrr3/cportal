import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/task_status_enum.dart';
import 'package:equatable/equatable.dart';

class DeclarationStepEntity extends Equatable {
  final String id;
  final DateTime date;
  final String responsibleName;
  final String responsiblePosition;
  final String responsibleImage;
  final String description;
  final TaskStatusEnum status;
  final DateTime descriptionDate;
  final String comment;

  const DeclarationStepEntity({
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

  @override
  List<Object?> get props => [
        id,
        date,
        responsibleName,
        responsiblePosition,
        responsibleImage,
        description,
        status,
        descriptionDate,
        comment,
      ];
}
