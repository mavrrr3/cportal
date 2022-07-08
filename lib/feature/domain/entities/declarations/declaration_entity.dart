class DeclarationEntity {
  final String id;
  final String title;
  final DateTime date;
  final String status;
  final String currentStep;
  final String icon;

  const DeclarationEntity({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.currentStep,
    required this.icon,
  });
}
