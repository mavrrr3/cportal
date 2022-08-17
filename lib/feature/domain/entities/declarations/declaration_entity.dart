import 'package:cportal_flutter/feature/data/models/declarations/description_enum.dart';

class DeclarationEntity {
  final String id;
  final String title;
  final String description;
  final DescriptionEnum descriptionEnum;
  final DateTime date;
  final String status;

  const DeclarationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.descriptionEnum,
    required this.date,
    required this.status,
  });
}
