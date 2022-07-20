part of 'connecting_devices_bloc.dart';

abstract class ConnectingDevicesEvent extends Equatable {
  const ConnectingDevicesEvent();

  @override
  List<Object> get props => [];
}

class LoadConnectingDevices extends ConnectingDevicesEvent {}
