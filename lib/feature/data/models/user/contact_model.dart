import 'package:cportal_flutter/feature/domain/entities/user/contact_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable(createToJson: false)
@HiveType(typeId: 1)
class ContactModel {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final String contact;

  ContactModel(this.type, this.contact);

  factory ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);

  ContactEntity toEntity() => ContactEntity(type: type, contact: contact);
}
