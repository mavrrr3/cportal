import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:equatable/equatable.dart';

part 'connecting_code_event.dart';
part 'connecting_code_state.dart';

class ConnectingCodeBloc extends Bloc<ConnectingCodeEvent, ConnectingCodeState> {
  final IAuthRepository _authRepository;

  ConnectingCodeBloc(
    this._authRepository,
  ) : super(const ConnectingCodeInitial()) {
    on<LogInWithConnectingCode>(_onLogInWithConnectingCode, transformer: bloc_concurrency.sequential());
  }

  FutureOr<void> _onLogInWithConnectingCode(LogInWithConnectingCode event, Emitter<ConnectingCodeState> emit) async {
    if (event.connectingCode != '111111') {
      emit(const WrongConnectingCode());
      await Future.delayed(const Duration(seconds: 2), () => emit(const TryAgainLater()));
      await Future.delayed(const Duration(seconds: 30), () => emit(const ConnectingCodeInitial()));
    } else {
      final user = await _authRepository.logInWithConnectingCode(connectingCode: event.connectingCode);
      emit(AuthenticatedWithConnectingCode(user));
    }
  }
}
