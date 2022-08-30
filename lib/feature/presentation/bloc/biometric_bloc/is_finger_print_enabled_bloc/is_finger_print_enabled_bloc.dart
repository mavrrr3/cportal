import 'dart:async';
import 'package:cportal_flutter/feature/domain/usecases/biometric/is_finger_print_enabled_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class IsFingerPrintEnabledBloc extends Bloc<IsFingerPrintEnabledEvent, bool> {
  final IsFingerPrintEnabledUsecase _isFingerPrintEnabled;
  IsFingerPrintEnabledBloc(
    this._isFingerPrintEnabled,
  ) : super(false) {
    on<IsFingerPrintEnabledEvent>(
      _onCheckFingerPrintSupport,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr<void> _onCheckFingerPrintSupport(
    IsFingerPrintEnabledEvent _,
    Emitter<bool> emit,
  ) async {
    final bool isEnabled = await _isFingerPrintEnabled();

    emit(isEnabled);
  }
}

class IsFingerPrintEnabledEvent {
  const IsFingerPrintEnabledEvent();
}
