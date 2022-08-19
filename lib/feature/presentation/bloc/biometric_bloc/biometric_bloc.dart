import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/usecases/biometric/biometric_authenticate_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/biometric/get_available_biometrics.dart';
import 'package:cportal_flutter/feature/domain/usecases/biometric/save_enabled_biometrics_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  final GetAvailableBiometrics _getAvailableBiometrics;
  final BiometricAuthenticateUsecase _biometricAuthenticate;
  final SaveEnabledBiometricsUseCase _saveEnabledBiometrics;

  BiometricBloc(
    this._getAvailableBiometrics,
    this._biometricAuthenticate,
    this._saveEnabledBiometrics,
  ) : super(const BiometricInitialState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<CheckBiometricSupport>(
      _onCheckBiometricSupport,
      transformer: bloc_concurrency.sequential(),
    );
    on<EnrollBiometricAuth>(
      _onEnrollBiometricAuth,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr<void> _onCheckBiometricSupport(
    BiometricEvent _,
    Emitter<BiometricState> emit,
  ) async {
    final biometricTypeOrNull = await _getAvailableBiometrics();

    if (biometricTypeOrNull != null) {
      emit(BiometricSupported(biometricTypeOrNull));
    } else {
      emit(const BiometricNotSupported());
    }
  }

  FutureOr<void> _onEnrollBiometricAuth(
    EnrollBiometricAuth event,
    Emitter<BiometricState> emit,
  ) async {
    final isEnrolled = await _biometricAuthenticate(
      BiometricAuthenticateParams(localizedReason: event.localizedReason),
    );
    await _saveEnabledBiometrics(event.biometric);

    if (isEnrolled) {
      emit(const BiometricSuccessfullyEnrolled());
    }
  }
}
