// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cportal_flutter/feature/domain/entities/user/contact_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 1)
class ContactModel extends ContactEntity {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final String contact;

  const ContactModel(
    this.type,
    this.contact,
  ) : super(
          type: type,
          contact: contact,
        );

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);
}
