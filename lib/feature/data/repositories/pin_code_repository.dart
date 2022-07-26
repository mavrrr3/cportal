import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PinCodeRepository implements IPinCodeRepository {
  final HiveInterface _hive;

  PinCodeRepository(this._hive);

  @override
  Future<void> savePin({required String pinCode}) async {
    final box = await _hive.openBox<String>('pin_code');
    await box.put('pin_code', pinCode);
  }

  @override
  Future<bool> hasPinCode() async {
    final pin = await _getPin();

    return pin != null;
  }

  @override
  Future<bool> pinIsMatched({required String pinCode}) async {
    final savedPinCode = await _getPin();

    return savedPinCode == pinCode;
  }

  Future<String?> _getPin() async {
    final box = await _hive.openBox<String>('pin_code');

    return box.get('pin_code');
  }
}
