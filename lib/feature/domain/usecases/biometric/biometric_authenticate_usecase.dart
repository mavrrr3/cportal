import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:equatable/equatable.dart';

class BiometricAuthenticateUsecase {
  final IBiometricRepository _biometricRepository;

  BiometricAuthenticateUsecase(this._biometricRepository);

  Future<bool> call(BiometricAuthenticateParams params) => _biometricRepository
      .authenticate(localizedReason: params.localizedReason);
}

class BiometricAuthenticateParams extends Equatable {
  final String localizedReason;

  const BiometricAuthenticateParams({
    required this.localizedReason,
  });
  @override
  List<Object?> get props => [localizedReason];
}
