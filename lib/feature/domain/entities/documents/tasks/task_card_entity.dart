import 'package:cportal_flutter/feature/data/models/documents/declarations/description_enum.dart';
import 'package:equatable/equatable.dart';

class TaskCardEntity extends Equatable {
  final String id;
  final DateTime date;
  final String status;
  final String title;
  final String description;
  final DescriptionEnum descriptionEnum;
  final DateTime descriptionDate;
  final String? userPhoto;

  const TaskCardEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.descriptionEnum,
    required this.date,
    required this.status,
    required this.descriptionDate,
    required this.userPhoto,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        status,
        title,
        description,
        descriptionEnum,
        descriptionDate,
        userPhoto,
      ];
}
