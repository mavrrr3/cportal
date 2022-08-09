import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_status_entity.dart';

class DeclarationStepEntity {
  final String title;
  final DateTime date;
  final DeclarationStatusEnum status;

  DeclarationStepEntity({
    required this.title,
    required this.date,
    required this.status,
  });
}
