// ignore_for_file: annotate_overrides, overridden_fields

import 'package:cportal_flutter/feature/data/models/documents/declarations/description_enum.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_card_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'task_card_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 22)
class TaskCardModel extends TaskCardEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String title;

  @HiveField(4)
  final String description;

  @HiveField(5)
  @JsonKey(name: 'description_enum', defaultValue: DescriptionEnum.def)
  final DescriptionEnum descriptionEnum;

  @JsonKey(name: 'description_date')
  @HiveField(6)
  final DateTime descriptionDate;

  @JsonKey(name: 'photo]')
  @HiveField(7)
  final String? userPhoto;

  const TaskCardModel({
    required this.id,
    required this.date,
    required this.status,
    required this.title,
    required this.description,
    required this.descriptionEnum,
    required this.descriptionDate,
    required this.userPhoto,
  }) : super(
          id: id,
          date: date,
          status: status,
          title: title,
          description: description,
          descriptionEnum: descriptionEnum,
          descriptionDate: descriptionDate,
          userPhoto: userPhoto,
        );

  factory TaskCardModel.fromJson(Map<String, dynamic> json) =>
      _$TaskCardModelFromJson(json);
}
