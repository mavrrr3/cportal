class DeclarationEntity {
  final String id;
  final String title;
  final String description;
  final bool? isAllert;
  final DateTime date;
  final DateTime? expiresDate;
  final String status;
  final String statusColor;

  const DeclarationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isAllert,
    required this.date,
    required this.expiresDate,
    required this.status,
    required this.statusColor,
  });
}
