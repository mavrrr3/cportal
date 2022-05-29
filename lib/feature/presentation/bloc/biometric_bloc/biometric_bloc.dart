import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/biometric_usecase.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:local_auth/local_auth.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  BiometricUseCase biometricUseCase;
  BiometricBloc(
    this.biometricUseCase,
  ) : super(const BiometricState()) {
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

enum BiometricEnum {
  authenticated,
  notAuthenticated,
  error,
}

class BiometricState extends Equatable {
  final List<BiometricType> listBiometric;
  final BiometricEnum authStatus;

  const BiometricState({
    this.listBiometric = const <BiometricType>[],
    this.authStatus = BiometricEnum.notAuthenticated,
  });

  String getTitle(String route, BuildContext context) =>
      route == NavigationRouteNames.fingerPrint
          ? AppLocalizations.of(context)!.fingerPrint
          : AppLocalizations.of(context)!.useFaceId;

  String getPathIcon(String route) => route == NavigationRouteNames.fingerPrint
      ? 'finger_print.svg'
      : 'face_id.svg';

  BiometricState copyWith({
    List<BiometricType>? listBiometric,
    BiometricEnum? authStatus,
  }) {
    return BiometricState(
      listBiometric: listBiometric ?? this.listBiometric,
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object?> get props => [listBiometric, authStatus];
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
