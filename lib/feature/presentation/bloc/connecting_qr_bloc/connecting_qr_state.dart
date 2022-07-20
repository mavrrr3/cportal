part of 'connecting_qr_bloc.dart';

abstract class ConnectingQrState extends Equatable {
  final String qrData;

  const ConnectingQrState(this.qrData);

  @override
  List<Object> get props => [qrData];
}

class ConnectingQrInitial extends ConnectingQrState {
  const ConnectingQrInitial(String qrData) : super(qrData);
}

class ConnectingQrSuccessAuth extends ConnectingQrState {
  final UserEntity user;

  const ConnectingQrSuccessAuth({
    required this.user,
    required String qrData,
  }) : super(qrData);
}
