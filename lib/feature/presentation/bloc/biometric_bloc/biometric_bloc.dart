import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:local_auth/local_auth.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  final IBiometricRepository _biometricRepository;

  BiometricBloc(
    this._biometricRepository,
  ) : super(const BiometricInitialState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<CheckBiometricSupport>(_onCheckBiometricSupport, transformer: bloc_concurrency.sequential());
    on<EnrollBiometricAuth>(_onEnrollBiometricAuth, transformer: bloc_concurrency.sequential());
  }

  FutureOr<void> _onCheckBiometricSupport(BiometricEvent _, Emitter<BiometricState> emit) async {
    final isSupportedBiometric = await _biometricRepository.isSupportedBiometrics();

    if (isSupportedBiometric) {
      final biometricTypes = await _biometricRepository.getAvailableBiometrics();

      if (biometricTypes.contains(BiometricType.fingerprint)) {
        emit(const BiometricSupported(BiometricType.fingerprint));
      } else if (biometricTypes.contains(BiometricType.face)) {
        emit(const BiometricSupported(BiometricType.face));
      } else {
        emit(const BiometricNotSupported());
      }
    } else {
      emit(const BiometricNotSupported());
    }
  }

  FutureOr<void> _onEnrollBiometricAuth(EnrollBiometricAuth event, Emitter<BiometricState> emit) async {
    final isEnrolled = await _biometricRepository.authenticate(localizedReason: event.localizedReason);
    await _biometricRepository.saveEnabledBiometric(event.biometric);

    if (isEnrolled) {
      emit(const BiometricSuccessfullyEnrolled());
    }
  }
}
