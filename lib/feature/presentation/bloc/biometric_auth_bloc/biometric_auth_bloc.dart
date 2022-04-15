import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/biometric_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:local_auth/local_auth.dart';

enum BiometricEnum {
  authenticated,
  notAuthenticated,
  error,
}

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  BiometricUseCase biometricUseCase;
  BiometricBloc(
    this.biometricUseCase,
  ) : super(BiometricState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<BiometricEvent>(
      _hasAuth,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr<void> _hasAuth(
    BiometricEvent event,
    Emitter<BiometricState> emit,
  ) async {
    if (kDebugMode) log(event.toString());
    final isAuthOrFailure = await biometricUseCase.autheticate();
    isAuthOrFailure.fold(
      (failure) {
        emit(state.copyWith(authStatus: BiometricEnum.error));
      },
      (isAuth) {
        emit(state.copyWith(authStatus: BiometricEnum.authenticated));
      },
    );
    final listOrFailure = await biometricUseCase.getBiometrics();
    listOrFailure.fold(
      (failure) {
        emit(state.copyWith(authStatus: BiometricEnum.error));
      },
      (listBiometric) {
        emit(state.copyWith(listBiometric: listBiometric));
      },
    );
  }
}

class BiometricState {
  final List<BiometricType> listBiometric;
  final BiometricEnum authStatus;

  BiometricState({
    this.listBiometric = const <BiometricType>[],
    this.authStatus = BiometricEnum.notAuthenticated,
  });

  BiometricState copyWith({
    List<BiometricType>? listBiometric,
    BiometricEnum? authStatus,
  }) {
    return BiometricState(
      listBiometric: listBiometric ?? this.listBiometric,
      authStatus: authStatus ?? this.authStatus,
    );
  }
}

abstract class BiometricEvent extends Equatable {
  const BiometricEvent();

  @override
  List<Object> get props => [];
}

class GetBiometricEvent extends BiometricEvent {
  const GetBiometricEvent();
  @override
  List<Object> get props => [];
}
