import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

abstract class BiometricState extends Equatable {
  const BiometricState();

  @override
  List<Object> get props => [];
}

class BiometricInitialState extends BiometricState {
  const BiometricInitialState();
}

class BiometricSupported extends BiometricState {
  final BiometricType biometricType;

  const BiometricSupported(this.biometricType);

  @override
  List<Object> get props => [biometricType];
}

class BiometricNotSupported extends BiometricState {
  const BiometricNotSupported();
}

class BiometricSuccessfullyEnrolled extends BiometricState {
  const BiometricSuccessfullyEnrolled();
}

class BiometricEnrollFailed extends BiometricState {
  const BiometricEnrollFailed();
}
