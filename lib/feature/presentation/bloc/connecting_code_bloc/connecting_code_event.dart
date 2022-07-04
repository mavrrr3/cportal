part of 'connecting_code_bloc.dart';

abstract class ConnectingCodeEvent extends Equatable {
  const ConnectingCodeEvent();

  @override
  List<Object> get props => [];
}

class LogInWithConnectingCode extends ConnectingCodeEvent {
  final String connectingCode;

  const LogInWithConnectingCode(this.connectingCode);

  @override
  List<Object> get props => [connectingCode];
}
