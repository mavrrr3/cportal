import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_step_status_enum.dart';
import 'package:cportal_flutter/feature/data/models/declarations/description_enum.dart';

class DeclarationStepEntity {
  final String id;
  final DateTime date;
  final String responsibleName;
  final String responsiblePosition;
  final String responsibleImage;
  final DeclarationStepStatusEnum status;
  final String description;
  final DescriptionEnum descrtiptionEnum;
  final DateTime expiresDate;

  DeclarationStepEntity({
    required this.id,
    required this.date,
    required this.responsibleName,
    required this.responsiblePosition,
    required this.responsibleImage,
    required this.status,
    required this.description,
    required this.descrtiptionEnum,
    required this.expiresDate,
  });
}
