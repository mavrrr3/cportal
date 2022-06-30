abstract class IPinCodeLocalDataSource {
  /// Записывает [String] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<String> writePin(String pinCode);

  /// Запрашивает есть ли ПИН в кэше
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<String?> getPin();
}
