abstract class IPinCodeRepository {
  Future<void> savePin({required String pinCode});

  Future<bool> hasPinCode();

  Future<bool> pinIsMatched({required String pinCode});
}
