import 'package:cportal_flutter/feature/data/models/new_employee_model.dart';

abstract class INewEmployeeRemoteDataSource {
  /// Обращается к эндпойнту .....
  /// Возвращает [List<NewEmployeeModel>]
  /// Пробрасываем ошибки через [ServerException]
  Future<List<NewEmployeeModel>> fetchNewEmployeeOnboardingSlides();
}
