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
    var box = await hive.openBox<ContactsModel>('contacts');
    log(Hive.isBoxOpen('contacts').toString());

    if (!Hive.isBoxOpen('contacts')) {
      await Hive.openBox<ContactsModel>('contacts');
    } else {
      box = await Hive.openBox<ContactsModel>('contacts');
    }

    final contacts = box.get('contacts');

    if (kDebugMode) log('Contacts из кэша $contacts');

    await Hive.box<ContactsModel>('contacts').close();

    return contacts!;
  }

  @override
  Future<void> contactsToCache(ContactsModel contacts) async {
    // Удаляет box с диска.
    // await Hive.deleteBoxFromDisk('contacts');
    var box = await Hive.openBox<ContactsModel>('contacts');
    if (!Hive.isBoxOpen('contacts')) {
      await Hive.openBox<ContactsModel>('contacts');
    } else {
      box = await Hive.openBox<ContactsModel>('contacts');
    }

    log('ContactsModel сохранил в кэш ${contacts.count}');

    await box.put('contacts', contacts);

    await Hive.box<ContactsModel>('contacts').close();
  }
}
