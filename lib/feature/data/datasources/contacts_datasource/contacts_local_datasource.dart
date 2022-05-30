import 'dart:developer';

import 'package:cportal_flutter/feature/data/models/contacts_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class IContactsLocalDataSource {
  /// Извлекаем [ContactsModel] из кеша
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<ContactsModel> fetchContactsFromCache();

  /// Сохраняем [ContactsModel] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<void> contactsToCache(ContactsModel contacts);
}

class ContactsLocalDataSource implements IContactsLocalDataSource {
  final HiveInterface hive;

  ContactsLocalDataSource(this.hive);

  @override
  Future<ContactsModel> fetchContactsFromCache() async {
    final box = await hive.openBox<ContactsModel>('contacts');

    final contacts = box.get('contacts');

    if (kDebugMode) log('Contacts из кэша $contacts');

    await Hive.box<ContactsModel>('contacts').close();

    return contacts!;
  }

  @override
  Future<void> contactsToCache(ContactsModel contacts) async {
    if (kDebugMode) {
      log('Contacts сохранил в кэш');
    }

    final box = await hive.openBox<ContactsModel>('contacts');

    await box.put('contacts', contacts);

    await Hive.box<ContactsModel>('contacts').close();
  }
}
