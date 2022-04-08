abstract class UserRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<bool> logIn(String connectongCode);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<bool> logIn(String connectongCode) async {
    return true;
  }
}
