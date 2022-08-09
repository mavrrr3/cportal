// ignore_for_file: overridden_fields, override_on_non_overriding_member

import 'package:cportal_flutter/feature/data/models/user/declaration_user_model.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_data_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_step_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_status_entity.dart';
import 'package:hive/hive.dart';

part 'declaration_info_model.g.dart';

@HiveType(typeId: 16)
class DeclarationInfoModel extends DeclarationInfoEntity {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String title;

  @override
  @HiveField(2)
  final double progress;

  @override
  @HiveField(3)
  final String status;

  @override
  @HiveField(4)
  final String priority;

  @override
  @HiveField(5)
  final DeclarationUserModel initiator;

  @override
  @HiveField(6)
  final DeclarationUserModel responsible;

  @override
  @HiveField(7)
  final List<DeclarationStepModel> steps;

  @override
  @HiveField(8)
  final List<DeclarationDataModel> data;

  DeclarationInfoModel({
    required this.id,
    required this.title,
    required this.progress,
    required this.status,
    required this.priority,
    required this.initiator,
    required this.responsible,
    required this.steps,
    required this.data,
  }) : super(
          id: id,
          title: title,
          progress: progress,
          status: status,
          priority: priority,
          initiator: initiator,
          responsible: responsible,
          steps: steps,
          data: data,
        );

  factory DeclarationInfoModel.fromJson(Map<String, dynamic> json) =>
      DeclarationInfoModel(
        id: json['id'] as String,
        title: json['title'] as String,
        progress: json['progress'] as double,
        status: json['status'] as String,
        priority: json['priority'] as String,
        initiator: DeclarationUserModel.fromJson(
          json['initiator'] as Map<String, dynamic>,
        ),
        responsible: DeclarationUserModel.fromJson(
          json['responsible'] as Map<String, dynamic>,
        ),
        steps: List<DeclarationStepModel>.from(json['actions'].map(
          (dynamic x) => DeclarationStepModel.fromJson(
            x as Map<String, dynamic>,
          ),
        ) as Iterable<dynamic>),
        data: List<DeclarationDataModel>.from(
          json['declaration_data'].map((dynamic x) =>
                  DeclarationDataModel.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'progress': progress,
        'status': status,
        'priority': priority,
        'initiator': initiator.toJson(),
        'responsible': responsible.toJson(),
        'declaration_data':
            List<dynamic>.from(data.map<dynamic>((x) => x.toJson())),
        'actions': List<dynamic>.from(steps.map<dynamic>((x) => x.toJson())),
      };
}

@HiveType(typeId: 17)
class DeclarationStepModel extends DeclarationStepEntity {
  @override
  @HiveField(0)
  final String title;

  @override
  @HiveField(1)
  final DateTime date;

  @override
  @HiveField(2)
  final DeclarationStatusEnum status;

  DeclarationStepModel({
    required this.title,
    required this.date,
    required this.status,
  }) : super(title: title, date: date, status: status);

  factory DeclarationStepModel.fromJson(Map<String, dynamic> json) =>
      DeclarationStepModel(
        title: json['title'] as String,
        date: DateTime.parse(json['date'] as String),
        status: getDeclarationStepStatus(status: json['actions'] as String),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'date': date.toIso8601String(),
        'status': status,
      };
}

@HiveType(typeId: 16)
class DeclarationDataModel extends DeclarationDataEntity {
  @override
  @HiveField(0)
  final String title;

  @override
  @HiveField(1)
  final String description;

  DeclarationDataModel({
    required this.title,
    required this.description,
  }) : super(
          title: title,
          description: description,
        );

  factory DeclarationDataModel.fromJson(Map<String, dynamic> json) =>
      DeclarationDataModel(
        title: json['title'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'description': description,
      };
}
