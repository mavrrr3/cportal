  import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LogInWithPinCodeUseCase extends IUseCase<UserEntity?, LoginWitPinCodeParams> {
  final IUserRepository _userRepository;
  final IPinCodeRepository _pinCodeRepository;

  LogInWithPinCodeUseCase(
    this._userRepository,
    this._pinCodeRepository,
  );

  @override
  Future<Either<Failure, UserEntity?>> call(LoginWitPinCodeParams params) async {
    final pinIsMatched = await _pinCodeRepository.pinIsMatched(pinCode: params.pinCode);

    if (pinIsMatched) {
      return _userRepository.getUser();
    }

    return const Right(null);
  }
}

class LoginWitPinCodeParams extends Equatable {
  final String pinCode;

  const LoginWitPinCodeParams({
    required this.pinCode,
  });
  @override
  List<Object?> get props => [pinCode];
}
