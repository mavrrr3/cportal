import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/check_auth_usecase.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/login_user_usecase.dart';
import 'package:cportal_flutter/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/presentation/bloc/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUserUseCase loginUser;
  CheckAuthUseCase checkAuth;

  AuthBloc(
    this.loginUser,
    this.checkAuth,
  ) : super(const AuthInitial()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<ChangeAuthCode>(_onChange, transformer: bloc_concurrency.sequential());
    on<CheckAuth>(_onCheckAuth, transformer: bloc_concurrency.sequential());
    on<AuthEventImpl>(_onAuthorize, transformer: bloc_concurrency.sequential());
  }

  FutureOr<void> _onChange(
    ChangeAuthCode event,
    Emitter<AuthState> emit,
  ) {
    if (event.connectingCode.length != 6) emit(const AuthInitial());
  }

  FutureOr<void> _onCheckAuth(
    CheckAuth event,
    Emitter<AuthState> emit,
  ) async {
    log(event.toString());
    emit(const AuthInitial());

    final notAuth = await checkAuth();
    log(notAuth.toString());
    notAuth.fold(
      (failure) => const ErrorAuthState(error: 'Ошибка обработки кэша'),
      (isAuth) => emit(Authenticated(isAuth)),
    );
  }

  FutureOr<void> _onAuthorize(
    AuthEventImpl event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthInitial());

    final failureOrUser = await loginUser(
      LoginUserParams(connectingCode: event.connectingCode),
    );
    log(failureOrUser.toString());
    failureOrUser.fold(
      (failure) {
        emit(
          ErrorAuthState(error: _mapFailureToMessage(failure)),
        );
      },
      (user) {
        emit(AuthUser(user: user));
      },
    );
    if (kDebugMode) log('AuthState: ' + state.toString());
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Ошибка на сервере';
    case CacheFailure:
      return 'Ошибка обработки кэша';
    default:
      return 'Unexpected Error';
  }
}
