import 'package:cportal_flutter/feature/data/models/user_model.dart';

abstract class IUserRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<UserModel> login(String connectongCode);
}
