part of 'connecting_devices_bloc.dart';

abstract class ConnectingDevicesEvent extends Equatable {
  const ConnectingDevicesEvent();

  @override
  List<Object> get props => [];
}

class LoadConnectingDevices extends ConnectingDevicesEvent {}

class SendScannedData extends ConnectingDevicesEvent {
  final String scannedData;

  const SendScannedData(this.scannedData);

  @override
  List<Object> get props => [scannedData];
}

class EndOtherSessions extends ConnectingDevicesEvent {}
