import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/feature/domain/usecases/auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:local_auth/local_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(
    this._authUseCase,
  ) : super(const AuthInitialState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<CheckLogin>(_onCheckLogin, transformer: bloc_concurrency.sequential());
    on<LogInWithUser>(_onLogInWithUser, transformer: bloc_concurrency.sequential());
    on<LogInWithPinCode>(_onLogInWithPinCode, transformer: bloc_concurrency.sequential());
    on<LogInWithBiometrics>(_onLogInWithBiometrics, transformer: bloc_concurrency.sequential());
  }

  FutureOr<void> _onCheckLogin(AuthEvent _, Emitter<AuthState> emit) async {
    final hasAuthCredentials = await _authUseCase.hasAuthCredentials();

    if (hasAuthCredentials) {
      final enabledBiometricType = await _authUseCase.getEnabledBiometricType();
      emit(HasAuthCredentials(enabledBiometricType));
    } else {
      emit(const NotAuthenticated());
    }
  }

  FutureOr<void> _onLogInWithUser(LogInWithUser event, Emitter<AuthState> emit) async {
    emit(Authenticated(event.user));
  }

  FutureOr<void> _onLogInWithPinCode(LogInWithPinCode event, Emitter<AuthState> emit) async {
    final user = await _authUseCase.logInWithPinCode(event.pinCode);

    if (user == null) {
      final enabledBiometric = _getEnabledBiometric(state);
      emit(WrongPinCode(enabledBiometric));
      await Future.delayed(const Duration(seconds: 2), () => emit(TryAgainLater(enabledBiometric)));
      await Future.delayed(const Duration(seconds: 30), () => emit(HasAuthCredentials(enabledBiometric)));
    } else {
      emit(Authenticated(user));
    }
  }

  FutureOr<void> _onLogInWithBiometrics(LogInWithBiometrics event, Emitter<AuthState> emit) async {
    final user = await _authUseCase.logInWithBiometric(event.localizedReason);

    if (user != null) {
      emit(Authenticated(user));
    }
  }

  BiometricType? _getEnabledBiometric(AuthState state) {
    return state is HasAuthCredentials ? state.enabledBiometric : null;
  }
}
