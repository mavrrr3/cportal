import 'package:cportal_flutter/feature/domain/entities/user/contact_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String department;
  final String position;
  final DateTime birthDate;
  final List<ContactEntity> contacts;
  final String photoUrl;

  const UserEntity({
    required this.id,
    required this.name,
    required this.department,
    required this.position,
    required this.birthDate,
    required this.contacts,
    required this.photoUrl,
  });

  String get birthDayToString => DateFormat('d.MM.y').format(birthDate);

  String get email =>
      contacts.where((element) => element.type == 'Эл. почта').first.contact;

  String get officePhone => contacts
      .where((element) => element.type == 'Рабочий телефон')
      .first
      .contact;

  String get personalPhone => contacts
      .where((element) => element.type == 'Личный номер телефона')
      .first
      .contact;

  @override
  List<Object?> get props => [
        id,
        name,
        department,
        position,
        birthDate,
        contacts,
        photoUrl,
      ];
}
