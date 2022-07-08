// ignore_for_file: overridden_fields, override_on_non_overriding_member

import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_entity.dart';
import 'package:hive/hive.dart';

part 'declaration_model.g.dart';

@HiveType(typeId: 12)
class DeclarationModel extends DeclarationEntity {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final DateTime date;
  @override
  @HiveField(2)
  final String title;
  @override
  @HiveField(3)
  final String status;
  @override
  @HiveField(4)
  final String currentStep;
  @override
  @HiveField(5)
  final String icon;

  DeclarationModel({
    required this.title,
    required this.icon,
    required this.date,
    required this.id,
    required this.status,
    required this.currentStep,
  }) : super(
          title: title,
          icon: icon,
          date: date,
          id: id,
          status: status,
          currentStep: currentStep,
        );

  factory DeclarationModel.fromJson(Map<String, dynamic> json) => DeclarationModel(
        id: json['id'] as String,
        date: DateTime.parse(json['date'] as String),
        title: json['title'] as String,
        status: json['status'] as String,
        currentStep: json['current_step'] as String,
        icon: json['image'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'date': date.toIso8601String(),
        'title': title,
        'status': status,
        'image': icon,
        'current_step': currentStep,
      };
}
