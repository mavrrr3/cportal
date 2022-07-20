part of 'connecting_devices_bloc.dart';

abstract class ConnectingDevicesState extends Equatable {
  const ConnectingDevicesState();

  @override
  List<Object> get props => [];
}

class ConnectingDevicesInitial extends ConnectingDevicesState {}

class ConnectingDevicesLoaded extends ConnectingDevicesState {
  final List<ConnectingDeviceEntity> connectingDevices;

  const ConnectingDevicesLoaded(this.connectingDevices);

  @override
  List<Object> get props => [connectingDevices];
}
