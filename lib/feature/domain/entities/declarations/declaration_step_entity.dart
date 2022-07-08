
import 'package:cportal_flutter/feature/domain/entities/declarations/step_status.dart';

class DeclarationStepEntity {
  final String title;
  final DateTime date;
  final StepStatus status;

  DeclarationStepEntity({
    required this.title,
    required this.date,
    required this.status,
  });
}
