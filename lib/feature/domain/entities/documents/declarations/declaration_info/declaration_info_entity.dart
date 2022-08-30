import 'package:cportal_flutter/feature/data/models/documents/declarations/description_enum.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_data_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_document_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_step_entity.dart';
import 'package:equatable/equatable.dart';

class DeclarationInfoEntity extends Equatable {
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

  const DeclarationInfoEntity({
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

  @override
  List<Object?> get props => [
        id,
        date,
        title,
        status,
        currentStep,
        allSteps,
        progressDescription,
        priority,
        params,
        actions,
        documents,
      ];
}
