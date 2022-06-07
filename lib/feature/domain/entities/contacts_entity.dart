import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

class ContactsEntity extends Equatable {
  final int count;
  final List<ProfileEntity> favorites;
  final List<ProfileEntity> contacts;

  const ContactsEntity({
    required this.count,
    required this.contacts,
    required this.favorites,
  });

  @override
  List<Object?> get props => [count, contacts, favorites];
}
