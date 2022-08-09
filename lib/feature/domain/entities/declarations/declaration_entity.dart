import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_status_entity.dart';

class DeclarationEntity {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime? expiresDate;
  final List<DeclarationStatusEntity> statuses;

  const DeclarationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.expiresDate,
    required this.statuses,
  });
}
