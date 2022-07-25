import 'package:cportal_flutter/feature/data/models/main_search_model.dart';

abstract class IMainSearchRemoteDataSource {
  /// Пробрасываем ошибки через [ServerException].
  Future<List<MainSearchModel>> search(String query);
}
