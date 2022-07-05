import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class Authenticated extends AuthState {
  final UserEntity user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class NotAuthenticated extends AuthState {
  const NotAuthenticated();
}

class HasAuthCredentials extends AuthState {
  final BiometricType? enabledBiometric;

  const HasAuthCredentials(this.enabledBiometric);

  @override
  List<Object?> get props => [enabledBiometric];
}

class WrongPinCode extends HasAuthCredentials {
  const WrongPinCode(BiometricType? enabledBiometric) : super(enabledBiometric);
}

class TryAgainLater extends WrongPinCode {
  const TryAgainLater(BiometricType? enabledBiometric) : super(enabledBiometric);
}

class AuthErrorState extends HasAuthCredentials {
  final String error;

  const AuthErrorState(
    BiometricType? enabledBiometric,
    this.error,
  ) : super(enabledBiometric);

  @override
  List<Object?> get props => [error];
}
