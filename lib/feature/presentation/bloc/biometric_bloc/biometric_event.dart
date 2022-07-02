import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

abstract class BiometricEvent extends Equatable {
  const BiometricEvent();

  @override
  List<Object> get props => [];
}

class CheckBiometricSupport extends BiometricEvent {
  const CheckBiometricSupport();
}

class EnrollBiometricAuth extends BiometricEvent {
  final String localizedReason;
  final BiometricType biometric;

  const EnrollBiometricAuth(this.localizedReason, this.biometric);
}
