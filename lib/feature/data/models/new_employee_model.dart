import 'package:cportal_flutter/feature/domain/entities/new_employee_entity.dart';
import 'package:hive/hive.dart';

part 'new_employee_model.g.dart';

// ignore_for_file: overridden_fields
// ignore_for_file: annotate_overrides
@HiveType(typeId: 19)
class NewEmployeeModel extends NewEmployeeEntity {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final bool isVector;

  const NewEmployeeModel({
    required this.title,
    required this.description,
    required this.image,
    required this.isVector,
  }) : super(
          title: title,
          description: description,
          image: image,
          isVector: isVector,
        );

  factory NewEmployeeModel.fromJson(Map<String, dynamic> json) =>
      NewEmployeeModel(
        title: json['title'] as String,
        description: json['description'] as String,
        image: json['image'] as String,
        isVector: json['isVector'] != null ? json['isVector'] as bool : false,
      );
}
