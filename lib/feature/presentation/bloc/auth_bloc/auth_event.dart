import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventImpl extends AuthEvent {
  final String connectingCode;

  const AuthEventImpl(this.connectingCode);
}

class ChangeAuthCode extends AuthEvent {
  final String connectingCode;

  const ChangeAuthCode(this.connectingCode);
}

class CheckAuth extends AuthEvent {
  const CheckAuth();
}
