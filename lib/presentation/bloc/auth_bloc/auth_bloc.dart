import 'dart:developer';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/login_user_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/presentation/bloc/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUserUseCase loginUser;

  AuthBloc(this.loginUser) : super(const AuthInitial()) {
    on<ChangeAuthCode>((event, emit) async {
      if (event.connectingCode.length != 6) emit(const InProgress());
    });

    on<AuthEventImpl>((event, emit) async {
      emit(const InProgress());

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

      final failureOrUser = await loginUser(
        LoginUserParams(connectingCode: event.connectingCode),
      );
      log(event.connectingCode);
      failureOrUser.fold(
        (failure) {
          log(failure.toString());
          emit(
            ErrorAuthState(error: _mapFailureToMessage(failure)),
          );
        },
        (user) {
          emit(Authenticated(user: user));
        },
      );
      if (kDebugMode) log('AuthState: ' + state.toString());
    });
  }
}
