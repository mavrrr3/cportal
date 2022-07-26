part of 'connecting_qr_bloc.dart';

abstract class ConnectingQrEvent extends Equatable {
  const ConnectingQrEvent();

  @override
  List<Object> get props => [];
}

class CheckLoginCredentials extends ConnectingQrEvent {}

class ReceivedUser extends ConnectingQrEvent {
  final UserEntity user;

  const ReceivedUser({required this.user});

  @override
  List<Object> get props => [user];
}
