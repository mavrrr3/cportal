// ignore_for_file: overridden_fields

import 'package:cportal_flutter/feature/domain/entities/declaration_entity.dart';
import 'package:hive/hive.dart';

part 'declaration_model.g.dart';

@HiveType(typeId: 12)
class DeclarationModel extends DeclarationEntity {
  @override
  @HiveField(0)
  final String title;
  @override
  @HiveField(1)
  final String svgPath;
  @override
  @HiveField(2)
  final String date;
  @override
  @HiveField(3)
  final String number;
  @override
  @HiveField(4)
  final String status;

  const DeclarationModel({
    required this.title,
    required this.svgPath,
    required this.date,
    required this.number,
    required this.status,
  }) : super(
          title: title,
          svgPath: svgPath,
          date: date,
          number: number,
          status: status,
        );
}
