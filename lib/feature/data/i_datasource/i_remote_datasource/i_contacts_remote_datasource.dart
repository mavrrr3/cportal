import 'package:cportal_flutter/feature/data/models/contacts_model.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';

abstract class IContactsRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<ContactsModel> fetchContacts(int page);

  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<List<ProfileEntity>> fetchContactsBySearch(String query);
}
