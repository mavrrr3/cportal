import 'dart:developer';

import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:cportal_flutter/feature/domain/entities/contacts_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'contacts_model.g.dart';

// ignore_for_file: annotate_overrides, overridden_fields
@HiveType(typeId: 9)
class ContactsModel extends ContactsEntity {
  @HiveField(0)
  final List<ProfileModel> favorites;
  @HiveField(1)
  final int count;
  @HiveField(2)
  final List<ProfileModel> contacts;

  const ContactsModel({
    required this.contacts,
    required this.count,
    required this.favorites,
  }) : super(
          count: count,
          contacts: contacts,
          favorites: favorites,
        );

  factory ContactsModel.fromJson(Map<String, dynamic> json) {
    return ContactsModel(
      count: json['response']['count'] as int,
      contacts: json['response']['items'] != null
          ? List<ProfileModel>.from(json['response']['items'].map(
              (dynamic x) => ProfileModel.fromJson(x as Map<String, dynamic>),
            ) as Iterable<dynamic>)
          : [],
      favorites: json['response']['favorites'] != null
          ? List<ProfileModel>.from(json['response']['favorites'].map(
              (dynamic x) => ProfileModel.fromJson(x as Map<String, dynamic>),
            ) as Iterable<dynamic>)
          : [],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'items': List<dynamic>.from(contacts.map<dynamic>((x) => x.toJson())),
      };
}
