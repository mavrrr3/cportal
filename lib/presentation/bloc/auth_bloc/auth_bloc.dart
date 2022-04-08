import 'package:cportal_flutter/domain/usecases/users_usecases/login_user_usecase.dart';
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
      emit(state.copyWith(connectingCode: _connectingCode));
    });

    on<LoginUserSubmitted>((event, emit) async {
      emit(state.copyWith(submissionStatus: Submitting()));

      try {
        await loginUser(LoginUserParams(connectingCode: _connectingCode));
        emit(state.copyWith(submissionStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(submissionStatus: SubmissionFailed(e.toString())));
      }
    });
  }
}
