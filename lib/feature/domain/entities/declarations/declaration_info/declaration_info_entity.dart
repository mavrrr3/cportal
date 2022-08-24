import 'package:cportal_flutter/feature/data/models/declarations/description_enum.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_data_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_document_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_step_entity.dart';

class DeclarationInfoEntity {
  final String id;
  final DateTime date;
  final String title;
  final String status;
  final int currentStep;
  final int allSteps;
  final String progressDescription;
  final DescriptionEnum descriptionEnum;
  final String priority;
  final List<DeclarationDataEntity> params;
  final List<DeclarationStepEntity> actions;
  final List<DeclarationDocumentEntity> documents;

  DeclarationInfoEntity({
    required this.id,
    required this.date,
    required this.title,
    required this.status,
    required this.currentStep,
    required this.allSteps,
    required this.progressDescription,
    required this.descriptionEnum,
    required this.priority,
    required this.params,
    required this.actions,
    required this.documents,
  });
}
