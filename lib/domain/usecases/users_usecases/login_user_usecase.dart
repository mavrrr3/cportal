import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:cportal_flutter/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/usecase.dart';

class LoginUserUseCase extends UseCase<UserEntity, LoginUserParams> {
  final UserRepository userRepository;

  LoginUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, UserEntity>> call(
    LoginUserParams params,
  ) async {
    return await userRepository.login(params.connectingCode);
  }
}

class LoginUserParams extends Equatable {
  final String connectingCode;

  const LoginUserParams({required this.connectingCode});
  @override
  List<Object?> get props => [connectingCode];
}
