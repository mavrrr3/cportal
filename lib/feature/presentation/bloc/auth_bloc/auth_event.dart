import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckLogin extends AuthEvent {
  const CheckLogin();
}

class LogInWithUser extends AuthEvent {
  final UserEntity user;

  const LogInWithUser(this.user);

  @override
  List<Object> get props => [user];
}

class LogInWithPinCode extends AuthEvent {
  final BuildContext context;
  final String pinCode;

  const LogInWithPinCode(this.context, this.pinCode);

  @override
  List<Object> get props => [pinCode];
}

class LogInWithBiometrics extends AuthEvent {
  final String localizedReason;

  const LogInWithBiometrics(this.localizedReason);
}
