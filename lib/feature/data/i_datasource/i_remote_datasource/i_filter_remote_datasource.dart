import 'package:cportal_flutter/feature/data/models/filter_model.dart';

abstract class IFilterRemoteDataSource {
  // Пробрасываем ошибки через [ServerException].
  Future<FilterResponseModel> fetchContactsFilters();

  // Пробрасываем ошибки через [ServerException].
  Future<FilterResponseModel> fetchDeclarationsFilters();
}
