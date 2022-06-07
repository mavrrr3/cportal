import 'dart:convert';
import 'dart:developer';

import 'package:cportal_flutter/app_config.dart';
import 'package:dio/dio.dart';

import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/contacts_model.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';

abstract class IContactsRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<ContactsModel> fetchContacts(int page);
}

class ContactsRemoteDataSource implements IContactsRemoteDataSource {
  final IContactsLocalDataSource localDatasource;
  final Dio dio;

  ContactsRemoteDataSource(this.localDatasource, this.dio);

  @override
  Future<ContactsModel> fetchContacts(int page) async {
    final String baseUrl =
        'http://ribadi.ddns.net:88/cportal/hs/api/contacts/1.0/?page=$page';
    try {
      final response = await dio.get<String>(baseUrl);

      final contacts = ContactsModel.fromJson(
        json.decode(response.data!) as Map<String, dynamic>,
      );

      log('ContactsRemouteDataSource  ==========  ${contacts.contacts.length}');
      await localDatasource.contactsToCache(contacts);

      return contacts;
    } on ServerException {
      throw ServerFailure();
    }
  }
}
