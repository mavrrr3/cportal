import 'package:cportal_flutter/feature/data/models/documents/declarations/description_enum.dart';
import 'package:equatable/equatable.dart';

class DeclarationCardEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DescriptionEnum descriptionEnum;
  final DateTime date;
  final String status;

  const DeclarationCardEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.descriptionEnum,
    required this.date,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        descriptionEnum,
        date,
        status,
      ];
}
