import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_status_enum.dart';

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
