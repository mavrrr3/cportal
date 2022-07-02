import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PinCodeRepository implements IPinCodeRepository {
  PinCodeRepository();

  @override
  Future<void> savePin(String pinCode) async {
    final box = await Hive.openBox<String>('pin_code');
    await box.put('pin_code', pinCode);
  }

  @override
  Future<bool> hasPinCode() async {
    final pin = await _getPin();

    return pin != null;
  }

  @override
  Future<bool> pinIsMatched(String pinCode) async {
    final savedPinCode = await _getPin();

    return savedPinCode == pinCode;
  }

  Future<String?> _getPin() async {
    final box = await Hive.openBox<String>('pin_code');

    return box.get('pin_code');
  }
}
