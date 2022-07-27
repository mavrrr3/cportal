import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/auth/has_auth_credentials_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/auth/log_in_with_biometrics_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/auth/log_in_with_pin_code_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:local_auth/local_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogInWithPinCodeUseCase _logInWithPinCode;
  final LogInWithBiometricsUseCase _logInWithBiometrics;
  final HasAuthCredentialsUseCase _hasAuthCredentialsUseCase;
  // TODO: usecase.
  final IBiometricRepository _biometricRepository;

  AuthBloc(
    this._logInWithPinCode,
    this._logInWithBiometrics,
    this._hasAuthCredentialsUseCase,
    this._biometricRepository,
  ) : super(const AuthInitialState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<CheckLogin>(_onCheckLogin, transformer: bloc_concurrency.droppable());
    on<LogInWithUser>(_onLogInWithUser, transformer: bloc_concurrency.droppable());
    on<LogInWithPinCode>(_onLogInWithPinCode, transformer: bloc_concurrency.droppable());
    on<LogInWithBiometrics>(_onLogInWithBiometrics, transformer: bloc_concurrency.droppable());
  }

  FutureOr<void> _onCheckLogin(AuthEvent _, Emitter<AuthState> emit) async {
    final hasAuthCredentials = await _hasAuthCredentialsUseCase();

    if (hasAuthCredentials) {
      final enabledBiometricType =
          await _biometricRepository.getEnabledBiometric();
      emit(HasAuthCredentials(enabledBiometricType));
    } else {
      emit(const NotAuthenticated());
    }
  }

  FutureOr<void> _onLogInWithUser(
    LogInWithUser event,
    Emitter<AuthState> emit,
  ) async {
    emit(Authenticated(event.user));
  }

  FutureOr<void> _onLogInWithPinCode(
    LogInWithPinCode event,
    Emitter<AuthState> emit,
  ) async {
    final response =
        await _logInWithPinCode(LoginWitPinCodeParams(pinCode: event.pinCode));

    await response.fold<FutureOr<void>>(
      (failure) async {
        await _onWrongPinCode(emit);
      },
      (user) => _onLogIn(emit, user),
    );
  }

  FutureOr<void> _onLogInWithBiometrics(
    LogInWithBiometrics event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _logInWithBiometrics(
      LoginWithBiometricsParams(localizedReason: event.localizedReason),
    );

    response.fold((failure) {}, (user) => _onLogIn(emit, user));
  }

  Future<void> _onWrongPinCode(Emitter<AuthState> emit) async {
    final enabledBiometric = _getEnabledBiometric(state);
    emit(WrongPinCode(enabledBiometric));
    await Future.delayed(
      const Duration(seconds: 2),
      () => emit(TryAgainLater(enabledBiometric)),
    );
    await Future.delayed(
      const Duration(seconds: 30),
      () => emit(HasAuthCredentials(enabledBiometric)),
    );
  }

  void _onLogIn(Emitter<AuthState> emit, UserEntity? user) {
    if (user != null) {
      emit(Authenticated(user));
    }
  }

  BiometricType? _getEnabledBiometric(AuthState state) {
    return state is HasAuthCredentials ? state.enabledBiometric : null;
  }
}
