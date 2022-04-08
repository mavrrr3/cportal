import 'dart:developer';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/login_user_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/presentation/bloc/submission_status.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUserUseCase loginUser;

  AuthBloc(this.loginUser) : super(AuthState()) {
    late String _connectingCode;

    on<ConnectingCodeChanged>((event, emit) async {
      _connectingCode = event.connectingCode;

      if (kDebugMode) log('AuthBloc _connectingCode $_connectingCode');

      emit(state.copyWith(connectingCode: _connectingCode));
    });

    on<LoginUserSubmitted>((event, emit) async {
      emit(state.copyWith(submissionStatus: Submitting()));

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

      final failureOrUser =
          await loginUser(LoginUserParams(connectingCode: _connectingCode));

      failureOrUser.fold(
        (failure) {
          emit(
            state.copyWith(
              submissionStatus: SubmissionFailed(_mapFailureToMessage(failure)),
            ),
          );
        },
        (user) {
          emit(state.copyWith(submissionStatus: SubmissionSuccess()));
        },
      );
      if (kDebugMode) log('AuthState: ' + state.toString());
    });
  }
}
