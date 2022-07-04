import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:local_auth/local_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  final IPinCodeRepository _pinCodeRepository;
  final IBiometricRepository _biometricRepository;

  AuthBloc(
    this._authRepository,
    this._pinCodeRepository,
    this._biometricRepository,
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
    final isAuthenticated = await _authRepository.isAuthenticated();
    final hasPinCode = await _pinCodeRepository.hasPinCode();
    final biometricType = await _biometricRepository.getEnabledBiometric();

    if (isAuthenticated && hasPinCode) {
      emit(HasAuthCredentials(biometricType));
    } else {
      emit(const NotAuthenticated());
    }
  }

  FutureOr<void> _onLogInWithUser(LogInWithUser event, Emitter<AuthState> emit) async {
    emit(Authenticated(event.user));
  }

  FutureOr<void> _onLogInWithPinCode(LogInWithPinCode event, Emitter<AuthState> emit) async {
    final pinIsMatched = await _pinCodeRepository.pinIsMatched(event.pinCode);
    final enabledBiometric = _getEnabledBiometric(state);

    if (!pinIsMatched) {
      emit(WrongPinCode(enabledBiometric));
      await Future.delayed(const Duration(seconds: 2), () => emit(TryAgainLater(enabledBiometric)));
      await Future.delayed(const Duration(seconds: 30), () => emit(HasAuthCredentials(enabledBiometric)));
    } else {
      final user = await _authRepository.getUser();
      emit(Authenticated(user));
    }
  }

  FutureOr<void> _onLogInWithBiometrics(LogInWithBiometrics event, Emitter<AuthState> emit) async {
    final isAuthenticated = await _biometricRepository.authenticate(localizedReason: event.localizedReason);

    if (isAuthenticated) {
      final user = await _authRepository.getUser();
      emit(Authenticated(user));
    }
  }

  BiometricType? _getEnabledBiometric(AuthState state) {
    return state is HasAuthCredentials ? state.enabledBiometric : null;
  }
}
