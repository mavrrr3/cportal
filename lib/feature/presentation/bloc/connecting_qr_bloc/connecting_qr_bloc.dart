import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/auth/log_in_with_connecting_code_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/connecting_qr/connecting_params.dart';
import 'package:cportal_flutter/feature/domain/usecases/connecting_qr/generate_connecting_code_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/connecting_qr/send_connecting_data_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

part 'connecting_qr_event.dart';
part 'connecting_qr_state.dart';

class ConnectingQrBloc extends Bloc<ConnectingQrEvent, ConnectingQrState> {
  final LogInWithConnectingCodeUseCase _logInWithConnectingCode;
  // ignore: unused_field
  final GenerateConnectingCodeUseCase _generateConnectingCode;
  final SendConnectingDataUseCase _sendConnectingData;

  ConnectingQrBloc(
    this._logInWithConnectingCode,
    this._generateConnectingCode,
    this._sendConnectingData,
  ) : super(ConnectingQrInitial(_generateConnectingCode())) {
    _setupEvents();
    add(CheckLoginCredentials());

    _sendConnectingData(ConnectingParams(connectingCode: state.qrData));
  }

  void _setupEvents() {
    on<CheckLoginCredentials>(_onCheckLoginCredentials,
        transformer: bloc_concurrency.droppable());
    on<ReceivedUser>(_onReceivedUser,
        transformer: bloc_concurrency.sequential());
  }

  FutureOr<void> _onCheckLoginCredentials(
      ConnectingQrEvent _, Emitter<ConnectingQrState> __) async {
    await Future.delayed(const Duration(seconds: 2), _tryGetUser);
  }

  FutureOr<void> _onReceivedUser(
      ReceivedUser event, Emitter<ConnectingQrState> emit) {
    emit(ConnectingQrSuccessAuth(user: event.user, qrData: state.qrData));
  }

  Future<void> _tryGetUser() async {
    final response = await _logInWithConnectingCode(
        LoginWithConnectingCodeParams(connectingCode: state.qrData));
    if (!isClosed) {
      response.fold(
        (failure) => add(CheckLoginCredentials()),
        (user) => add(ReceivedUser(user: user)),
      );
    }
  }
}
