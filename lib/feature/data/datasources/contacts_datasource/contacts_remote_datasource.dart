import 'dart:convert';
import 'dart:developer';
import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:dio/dio.dart';

import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/models/contacts_model.dart';

class ContactsRemoteDataSource implements IContactsRemoteDataSource {
  final IContactsLocalDataSource localDataSource;
  final Dio dio;

  ContactsRemoteDataSource(
    this.localDataSource,
    this.dio,
  );

  @override
  Future<ContactsModel> fetchContacts(int page) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/contacts/1.0/?page=$page';
    try {
      log('====== ${AppConfig.authKey}');
      final response = await dio.get<String>(baseUrl);

      final contacts = ContactsModel.fromJson(
        json.decode(response.data!) as Map<String, dynamic>,
      );

      log('ContactsRemouteDataSource  ==========  ${contacts.contacts.length}');
      await localDataSource.contactsToCache(contacts);

      return contacts;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<List<ProfileModel>> fetchContactsBySearch(
    String query,
    List<FilterEntity> filters,
  ) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/contacts/1.0/?q=$query';
    try {
      final List<Map<String, dynamic>> selectedFilers = [];
      if (filters.isNotEmpty) {
        for (final filter in filters) {
          selectedFilers.add(filter.toJson());
        }
      }
      final body = <String, dynamic>{
        'request': selectedFilers,
      };
      log(json.encode(body));
      final response = await dio.post<String>(
        baseUrl,
        data: json.encode(body),
      );

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
