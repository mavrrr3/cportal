import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/entities/device/connecting_device_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_connecting_devices_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/connecting_qr/connecting_params.dart';
import 'package:cportal_flutter/feature/domain/usecases/connecting_qr/send_scanned_data_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

part 'connecting_devices_event.dart';
part 'connecting_devices_state.dart';

class ConnectingDevicesBloc extends Bloc<ConnectingDevicesEvent, ConnectingDevicesState> {
  final IConnectingDevicesRepository _connectingDevicesRepository;
  final SendScannedDataUseCase _sendScannedDataUseCase;

  ConnectingDevicesBloc(
    this._connectingDevicesRepository,
    this._sendScannedDataUseCase,
  ) : super(ConnectingDevicesInitial()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<LoadConnectingDevices>(_onLoadConnectingDevices, transformer: bloc_concurrency.droppable());
    on<SendScannedData>(_onSendScannedData, transformer: bloc_concurrency.droppable());
    on<EndOtherSessions>(_onEndOtherSessions, transformer: bloc_concurrency.droppable());
  }

  FutureOr<void> _onLoadConnectingDevices(ConnectingDevicesEvent _, Emitter<ConnectingDevicesState> emit) async {
    final response = await _connectingDevicesRepository.getConnectingDevices();
    response.fold(
      (failure) {},
      (devices) => emit(ConnectingDevicesLoaded(devices.items)),
    );
  }

  FutureOr<void> _onSendScannedData(SendScannedData event, Emitter<ConnectingDevicesState> __) async {
    await _sendScannedDataUseCase(ConnectingParams(connectingCode: event.scannedData));
    add(LoadConnectingDevices());
  }

  FutureOr<void> _onEndOtherSessions(ConnectingDevicesEvent _, Emitter<ConnectingDevicesState> __) async {
    await _connectingDevicesRepository.endOtherSessions();
    add(LoadConnectingDevices());
  }
}
