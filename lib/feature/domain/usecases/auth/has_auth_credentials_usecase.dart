import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_user_repository.dart';

class HasAuthCredentialsUseCase {
  final IUserRepository _userRepository;
  final IPinCodeRepository _pinCodeRepository;

  HasAuthCredentialsUseCase(
    this._userRepository,
    this._pinCodeRepository,
  );

  Future<bool> call() async {
    final hasUser = await _userRepository.hasCachedUser();
    final pinCodeIsCreated = await _pinCodeRepository.hasPinCode();

    return hasUser && pinCodeIsCreated;
  }
}
