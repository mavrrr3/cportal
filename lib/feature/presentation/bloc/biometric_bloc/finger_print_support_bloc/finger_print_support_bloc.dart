import 'dart:async';

import 'package:cportal_flutter/feature/domain/usecases/biometric/get_available_biometrics.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:local_auth/local_auth.dart';

class FingerPrintSupportBloc extends Bloc<CheckFingerPrintSupport, bool> {
  final GetAvailableBiometrics _getAvailableBiometrics;
  FingerPrintSupportBloc(
    this._getAvailableBiometrics,
  ) : super(false) {
    on<CheckFingerPrintSupport>(
      _onCheckFingerPrintSupport,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr<void> _onCheckFingerPrintSupport(
    CheckFingerPrintSupport _,
    Emitter<bool> emit,
  ) async {
    final biometricTypeOrNull = await _getAvailableBiometrics();

    if (biometricTypeOrNull == BiometricType.fingerprint) {
      emit(true);
    }
  }
}

class CheckFingerPrintSupport {
  const CheckFingerPrintSupport();
}
