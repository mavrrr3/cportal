import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LogInWithConnectingCodeUseCase
    extends IUseCase<UserEntity, LoginWithConnectingCodeParams> {
  final IAuthRepository _authRepository;

  LogInWithConnectingCodeUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(
      LoginWithConnectingCodeParams params) {
    return _authRepository.logInWithConnectingCode(
        connectingCode: params.connectingCode);
  }
}

class LoginWithConnectingCodeParams extends Equatable {
  final String connectingCode;

  const LoginWithConnectingCodeParams({
    required this.connectingCode,
  });
  @override
  List<Object?> get props => [connectingCode];
}
