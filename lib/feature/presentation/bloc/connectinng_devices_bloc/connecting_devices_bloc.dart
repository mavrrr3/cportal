import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/entities/device/connecting_device_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_connecting_devices_repository.dart';
import 'package:equatable/equatable.dart';

part 'connecting_devices_event.dart';
part 'connecting_devices_state.dart';

class ConnectingDevicesBloc extends Bloc<ConnectingDevicesEvent, ConnectingDevicesState> {
  final IConnectingDevicesRepository _connectingDevicesRepository;

  ConnectingDevicesBloc(
    this._connectingDevicesRepository,
  ) : super(ConnectingDevicesInitial()) {
    on<LoadConnectingDevices>(_onLoadConnectingDevices);
  }

  FutureOr<void> _onLoadConnectingDevices(ConnectingDevicesEvent _, Emitter<ConnectingDevicesState> emit) async {
    final connectingDevices = await _connectingDevicesRepository.getConnectingDevices();

    emit(ConnectingDevicesLoaded(connectingDevices.items.map((e) => e.toEntity()).toList()));
  }
}
