import 'package:cportal_flutter/feature/data/models/documents/declarations/description_enum.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_info/task_action_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_info/task_document_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_info/task_parametr_entity.dart';
import 'package:equatable/equatable.dart';

class TaskInfoEntity extends Equatable {
  final String id;
  final DateTime date;
  final String title;
  final String status;
  final int currentStep;
  final int allSteps;
  final String description;
  final DescriptionEnum descriptionEnum;
  final String content;
  final String priority;
  final String initiatorName;
  final String initiatorPosition;
  final String initiatorImage;
  final List<TaskDocumentEntity> documents;
  final List<TaskParametrEntity> parametrs;
  final List<TaskActionEntity> actions;

  const TaskInfoEntity({
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
  });

  @override
  List<Object?> get props => [];
}
