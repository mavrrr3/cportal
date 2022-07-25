import 'package:cportal_flutter/feature/data/models/contacts_model.dart';

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
