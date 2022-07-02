abstract class IPinCodeRepository {
  Future<void> savePin(String pinCode);

  Future<bool> hasPinCode();

  Future<bool> pinIsMatched(String pinCode);
}
