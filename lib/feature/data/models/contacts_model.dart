import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:cportal_flutter/feature/domain/entities/contacts_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'contacts_model.g.dart';

// ignore_for_file: annotate_overrides, overridden_fields
@HiveType(typeId: 10)
class ContactsModel extends ContactsEntity {
  @HiveField(0)
  final List<ProfileModel> favorites;
  @HiveField(1)
  final List<ProfileModel> contacts;

  const ContactsModel({
    required this.contacts,
    required this.favorites,
  }) : super(
          contacts: contacts,
          favorites: favorites,
        );
}
