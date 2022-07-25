import 'dart:convert';
import 'dart:developer';
import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:dio/dio.dart';

import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/models/contacts_model.dart';

class ContactsRemoteDataSource implements IContactsRemoteDataSource {
  final IContactsLocalDataSource localDataSource;
  final Dio _dio;

  ContactsRemoteDataSource(
    this.localDataSource,
    this._dio,
  );

  @override
  Future<ContactsModel> fetchContacts(int page) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/contacts/1.0/?page=$page';

    try {
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'POST', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      log('+++++++++++++++++++   ${response.data}');

      final contacts = ContactsModel.fromJson(response.data!);

      log('ContactsRemouteDataSource  ==========  ${contacts.contacts.length}');
      await localDataSource.contactsToCache(contacts);

      return contacts;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<List<ProfileEntity>> fetchContactsBySearch(String query) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/contacts/1.0/?q=$query';
    try {
      final response = await _dio.get<String>(baseUrl);

      final contactsModel = ContactsModel.fromJson(
        json.decode(response.data!) as Map<String, dynamic>,
      );

      log('ContactsRemouteDataSource  ==========  ${contactsModel.contacts.length}');

      return contactsModel.contacts;
    } on ServerException {
      throw ServerFailure();
    }
  }
}
