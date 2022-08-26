// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_document_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'declaration_document_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 20)
class DeclarationDocumentModel extends DeclarationDocumentEntity {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String file;

  DeclarationDocumentModel({required this.title, required this.file})
      : super(title: title, file: file);

  factory DeclarationDocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DeclarationDocumentModelFromJson(json);
}
