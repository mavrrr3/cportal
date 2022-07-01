part of 'connecting_code_bloc.dart';

abstract class ConnectingCodeState extends Equatable {
  const ConnectingCodeState();

  @override
  List<Object> get props => [];
}

class ConnectingCodeInitial extends ConnectingCodeState {
  const ConnectingCodeInitial();
}

class AuthenticatedWithConnectingCode extends ConnectingCodeState {
  final UserEntity user;

  const AuthenticatedWithConnectingCode(this.user);

  @override
  List<Object> get props => [user];
}

class WrongConnectingCode extends ConnectingCodeState {
  const WrongConnectingCode();
}

class TryAgainLater extends WrongConnectingCode {
  const TryAgainLater();
}

class ConnectingCodeError extends ConnectingCodeState {
  const ConnectingCodeError();
}
