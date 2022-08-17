import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_enum.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_data_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_document_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_step_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_user_entity.dart';

class DeclarationInfoEntity {
  final String id;
  final String title;
  final DeclarationEnum type;
  final DateTime date;
  final String priority;
  final double progress;
  final DeclarationUserEntity initiator;
  final DeclarationUserEntity responsible;
  final List<DeclarationStepEntity> steps;
  final List<DeclarationDocumentEntity> documents;
  final List<DeclarationDataEntity> data;

  DeclarationInfoEntity({
    required this.id,
    required this.title,
    required this.type,
    required this.progress,
    required this.date,
    required this.priority,
    required this.initiator,
    required this.responsible,
    required this.steps,
    required this.documents,
    required this.data,
  });
}
