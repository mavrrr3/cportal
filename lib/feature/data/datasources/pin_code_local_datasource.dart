import 'dart:developer';
// import 'package:cportal_flutter/feature/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IPinCodeDataSource {
  /// Записывает [String] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<String> writePin(String pinCode);

  /// Запрашивает есть ли ПИН в кэше
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<String?> getPin();
}

class PinCodeDataSource implements IPinCodeDataSource {
  @override
  Future<String> writePin(String pinCode) async {
    // await Hive.deleteBoxFromDisk('pin_code');

    // Открывает Box
    var box = await Hive.openBox<String>('pin_code');

    await box.put('pin_code', pinCode);

    if (kDebugMode) log('pinCode записал в кэш ' + pinCode.toString());

    // Закрывает Box
    await Hive.box<String>('pin_code').close();

    // Возвращает записаный ПИН
    return pinCode;
  }

  @override
  Future<String?> getPin() async {
    // await Hive.deleteBoxFromDisk('pin_code');

    // Открывает Box
    var box = await Hive.openBox<String>('pin_code');

    // Запрашивает из локальной базы есть ли строка с ключём 'pin_code'
    String? localPin = box.get('pin_code');
    if (kDebugMode) log('pinCode в кэше ' + localPin.toString());

    // Проверяет если такой строки в базе нет
    // то записывает пришедший ПИН и
    // возвращает строку 'repeat'

    // Закрывает Box
    await Hive.box<String>('pin_code').close();

    // Возвращает записаный ПИН
    return localPin;
  }
}
