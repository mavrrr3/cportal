import 'package:cportal_flutter/feature/data/models/new_employee_model.dart';

abstract class INewEmployeeLocalDataSource {
  /// Извлекает [NewsModel] из кеша
  /// Возвращает [NewsModel]
  /// Пробрасываем все ошибки через [CacheException]
  Future<List<NewEmployeeModel>> fetchNewEmployeeOnboardingSlidesFromCache();

  /// Сохраняет [NewsModel] в кэш
  ///
  /// Пробрасывает все ошибки через [CacheException]
  Future<void> newEmployeeSlidesToCache(List<NewEmployeeModel> slides);
}
