import 'dart:developer';

import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/contacts_model.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';

abstract class IContactsRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<ContactsModel> fetchContacts();
}

class ContactsRemoteDataSource implements IContactsRemoteDataSource {
  final IContactsLocalDataSource localDatasource;

  ContactsRemoteDataSource(this.localDatasource);

  @override
  Future<ContactsModel> fetchContacts() async {
    try {
      final List<ProfileModel> usersList = [
        _user1,
        _user1,
        _user1,
        _user1,
        _user1,
        _user1,
      ];

      final remoteContacts = ContactsModel(
        count: 10,
        contacts: usersList,
        favorites: usersList,
      );

      log('ContactsRemouteDataSource  ==========  $remoteContacts');
      await localDatasource.contactsToCache(remoteContacts);

      return remoteContacts;
    } on ServerException {
      throw ServerFailure();
    }
  }
}

 final ProfileModel _user1 = ProfileModel(
  id: '111',
  fullName: 'Суханенков',
  birthday: DateTime.now(),
  photoLink:
      'https://avatars.mds.yandex.net/i?id=08365f5b8db600cf8af1086fdbe51e9d-5858549-images-thumbs&n=13&exp=1',
  position: '',
  department: '',
  phone: const [
    PhoneModel(
      type: '',
      contact: '',
    ),
  ],
);
