import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/feature/domain/usecases/auth_usecase.dart';
import 'package:equatable/equatable.dart';

part 'connecting_code_event.dart';
part 'connecting_code_state.dart';

class ConnectingCodeBloc extends Bloc<ConnectingCodeEvent, ConnectingCodeState> {
  final AuthUseCase _authUseCase;

  ConnectingCodeBloc(
    this._authUseCase,
  ) : super(const ConnectingCodeInitial()) {
    on<LogInWithConnectingCode>(_onLogInWithConnectingCode, transformer: bloc_concurrency.sequential());
  }

  FutureOr<void> _onLogInWithConnectingCode(LogInWithConnectingCode event, Emitter<ConnectingCodeState> emit) async {
    final user = await _authUseCase.loginWithConnectingCode(event.connectingCode);

    if (user != null) {
      emit(AuthenticatedWithConnectingCode(user));
    } else {
      emit(const WrongConnectingCode());
      await Future.delayed(const Duration(seconds: 2), () => emit(const TryAgainLater()));
      await Future.delayed(const Duration(seconds: 30), () => emit(const ConnectingCodeInitial()));
    }
  }
}
