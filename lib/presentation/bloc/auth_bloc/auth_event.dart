import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ConnectingCodeChanged extends AuthEvent {
  final String connectingCode;

  ConnectingCodeChanged(this.connectingCode);

  @override
  List<Object> get props => [connectingCode];
}

class LoginUserSubmitted extends AuthEvent {
  LoginUserSubmitted();
}
