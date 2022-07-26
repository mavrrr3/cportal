import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/feature/domain/usecases/auth/log_in_with_connecting_code_usecase.dart';
import 'package:equatable/equatable.dart';

part 'connecting_code_event.dart';
part 'connecting_code_state.dart';

class ConnectingCodeBloc extends Bloc<ConnectingCodeEvent, ConnectingCodeState> {
  final LogInWithConnectingCodeUseCase _logInWithConnectingCode;

  ConnectingCodeBloc(
    this._logInWithConnectingCode,
  ) : super(const ConnectingCodeInitial()) {
    on<LogInWithConnectingCode>(_onLogInWithConnectingCode, transformer: bloc_concurrency.droppable());
    on<ReadQrCode>(_onReadQrCode, transformer: bloc_concurrency.sequential());
  }

  FutureOr<void> _onLogInWithConnectingCode(LogInWithConnectingCode event, Emitter<ConnectingCodeState> emit) async {
    final response = await _logInWithConnectingCode(
      LoginWithConnectingCodeParams(
        connectingCode: event.connectingCode,
      ),
    );

    await response.fold<FutureOr<void>>(
      (failure) => _onLogInFailure(emit),
      (user) => emit(AuthenticatedWithConnectingCode(user)),
    );
  }

  Future<void> _onLogInFailure(Emitter<ConnectingCodeState> emit) async {
    emit(const WrongConnectingCode());
    await Future.delayed(const Duration(seconds: 2), () => emit(const TryAgainLater()));
    await Future.delayed(const Duration(seconds: 30), () => emit(const ConnectingCodeInitial()));
  }

  FutureOr<void> _onReadQrCode(ReadQrCode event, Emitter<ConnectingCodeState> emit) async {
    if (state is! WrongConnectingCode) {
      emit(ConnectingCodeQrReadSuccess(event.connectingCode));
    }
  }
}
