import 'package:cportal_flutter/feature/data/models/contacts_model.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';

abstract class IContactsRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<ContactsModel> fetchContacts(int page);

  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<List<ProfileModel>> fetchContactsBySearch(String query, List<FilterEntity> filters);
}
