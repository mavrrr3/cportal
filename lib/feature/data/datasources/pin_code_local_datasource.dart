import 'dart:developer';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_pin_code_local_datasource.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PinCodeDataSource implements IPinCodeLocalDataSource {
  @override
  Future<String> writePin(String pinCode) async {
    // await Hive.deleteBoxFromDisk('pin_code');

    // Открывает Box
    final box = await Hive.openBox<String>('pin_code');

    await box.put('pin_code', pinCode);

    if (kDebugMode) log('pinCode записал в кэш $pinCode');

    // Закрывает Box.
    await Hive.box<String>('pin_code').close();

    // Возвращает записаный ПИН.
    return pinCode;
  }

  @override
  Future<String?> getPin() async {
    // await Hive.deleteBoxFromDisk('pin_code');

    // Открывает Box
    final box = await Hive.openBox<String>('pin_code');

    // Запрашивает из локальной базы есть ли строка с ключём 'pin_code'.
    final String? localPin = box.get('pin_code');
    if (kDebugMode) log('pinCode в кэше $localPin');

    // Проверяет если такой строки в базе нет
    // то записывает пришедший ПИН и
    // возвращает строку 'repeat'

    // Закрывает Box
    await Hive.box<String>('pin_code').close();

    // Возвращает записаный ПИН.
    return localPin;
  }
}
