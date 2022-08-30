import 'dart:async';
import 'package:cportal_flutter/feature/domain/usecases/biometric/biometric_authenticate_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/biometric/get_enabled_biometric_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/biometric/is_finger_print_enabled_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/biometric/save_enabled_biometrics_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/biometric/turn_off_finger_print_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:local_auth/local_auth.dart';

class TurnOffFingerPrintBloc
    extends Bloc<FingerPrintEvent, TurnOffFingerState> {
  final TurnOffFingerPrintUseCase _turnOffFingerPrint;
  final GetEnabledBiometricUseCase _getEnabledBiometric;
  final BiometricAuthenticateUsecase _authenticate;
  final SaveEnabledBiometricsUseCase _saveEnabledBiometric;
  final IsFingerPrintEnabledUsecase _isFingerPrintEnabled;

  TurnOffFingerPrintBloc(
    this._turnOffFingerPrint,
    this._getEnabledBiometric,
    this._authenticate,
    this._saveEnabledBiometric,
    this._isFingerPrintEnabled,
  ) : super(const TurnOffFingerState(false)) {
    on<TurnOffFingerPrintEvent>(
      _onTurnFingerPrintSupport,
      transformer: bloc_concurrency.droppable(),
    );
    on<IsFingerPrintEnabledEvent>(
      _onCheckFingerPrintSupport,
      transformer: bloc_concurrency.droppable(),
    );
  }

  FutureOr<void> _onCheckFingerPrintSupport(
    IsFingerPrintEnabledEvent _,
    Emitter<TurnOffFingerState> emit,
  ) async {
    final bool isEnabled = await _isFingerPrintEnabled();

    emit(TurnOffFingerState(isEnabled));
  }

  FutureOr<void> _onTurnFingerPrintSupport(
    TurnOffFingerPrintEvent _,
    Emitter<TurnOffFingerState> emit,
  ) async {
    final enabledBiometric = await _getEnabledBiometric();

    if (enabledBiometric != null) {
      final bool isEnable = await _turnOffFingerPrint();

      emit(TurnOffFingerState(!isEnable));
    } else {
      final bool isEnable = await _authenticate(
        const BiometricAuthenticateParams(localizedReason: 'localizedReason'),
      );
      emit(TurnOffFingerState(isEnable));

      await _saveEnabledBiometric(
        isEnable ? BiometricType.fingerprint : BiometricType.iris,
      );
    }
  }
}

class FingerPrintEvent {
  const FingerPrintEvent();
}

class IsFingerPrintEnabledEvent extends FingerPrintEvent {
  const IsFingerPrintEnabledEvent();
}

class TurnOffFingerPrintEvent extends FingerPrintEvent {
  const TurnOffFingerPrintEvent();
}

class TurnOffFingerState extends Equatable {
  final bool isEnabled;

  const TurnOffFingerState(this.isEnabled);

  @override
  List<Object?> get props => [isEnabled];
}
