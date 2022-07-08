import 'package:cportal_flutter/common/util/random_color_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String fullName;
  final String department;
  final String position;
  final DateTime? birthday;
  final String photoLink;
  final List<ContactInfoEntity> contactInfo;
  final Color color = RandomColorService.color;

  ProfileEntity({
    required this.id,
    required this.fullName,
    required this.department,
    required this.position,
    required this.birthday,
    required this.photoLink,
    required this.contactInfo,
  });

  String? get birthDayToString =>
      birthday != null ? DateFormat('d.MM.y').format(birthday!) : null;

  String get email =>
      contactInfo.where((element) => element.type == 'Эл. почта').first.contact;

  String get officePhone => contactInfo
      .where((element) => element.type == 'Рабочий телефон')
      .first
      .contact;

  @override
  List<Object?> get props => [
        id,
        fullName,
        birthday,
        photoLink,
        position,
        contactInfo,
      ];
}

class ContactInfoEntity extends Equatable {
  final String type;
  final String contact;

  const ContactInfoEntity({
    required this.type,
    required this.contact,
  });

  @override
  List<Object?> get props => [type, contact];
}
