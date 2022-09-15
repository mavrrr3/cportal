import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LogInWithBiometricsUseCase
    extends IUseCase<UserEntity?, LoginWithBiometricsParams> {
  final IBiometricRepository _biometricRepository;
  final IUserRepository _userRepository;

  LogInWithBiometricsUseCase(this._biometricRepository, this._userRepository);

  @override
  Future<Either<Failure, UserEntity?>> call(
      LoginWithBiometricsParams params) async {
    final isAuthenticated = await _biometricRepository.authenticate(
        localizedReason: params.localizedReason);

    if (isAuthenticated) {
      return _userRepository.getUser();
    }

    return const Right(null);
  }
}

class LoginWithBiometricsParams extends Equatable {
  final String localizedReason;

  const LoginWithBiometricsParams({
    required this.localizedReason,
  });
  @override
  List<Object?> get props => [localizedReason];
}
