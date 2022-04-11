import 'dart:developer';
import 'package:cportal_flutter/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IPinCodeDataSource {
  /// Записывает [String] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<String> writePin(String pinCode);
}

class PinCodeLocalDataSource implements IPinCodeDataSource {
  @override
  Future<String> writePin(String pinCode) async {
    // await Hive.deleteBoxFromDisk('single_user');
    if (kDebugMode) log('pinCode проверяю в кэше ' + pinCode.toString());

    // Открывает Box
    var box = await Hive.openBox<String>('pin_code');

    // Запрашивает из локальной базы есть ли строка с ключём 'pin_code'
    String? localPin = box.get('pin_code');

    // Проверяет если такой строки в базе нет
    // то записывает пришедший ПИН и
    // возвращает строку 'repeat'
    if (localPin == null) {
      await box.put('pin_code', pinCode);

      return 'repeat';
    }

    // Закрывает Box
    await Hive.box<UserModel>('single_user').close();

    // Возвращает записаный ПИН
    return localPin;
  }
}
