import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class PinCodeBloc extends Bloc<PinCodeEvent, PinCodeState> {
  final IPinCodeRepository _pinCodeRepository;

  PinCodeBloc(
    this._pinCodeRepository,
  ) : super(PinCodeInitialState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<CreatePinCode>(_onCreatePinCode, transformer: bloc_concurrency.sequential());
    on<RepeatPinCode>(_onRepeatPinCode, transformer: bloc_concurrency.sequential());
  }

  FutureOr<void> _onCreatePinCode(
    CreatePinCode event,
    Emitter<PinCodeState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500), () => emit(PinCodeEditing(event.pinCode)));
  }

  FutureOr<void> _onRepeatPinCode(
    RepeatPinCode event,
    Emitter<PinCodeState> emit,
  ) async {
    if (state is! PinCodeEditing) return;

    final currentState = state as PinCodeEditing;

    if (currentState.pinCode != event.pinCode) {
      emit(PinCodeNotMatch());
      await Future.delayed(const Duration(seconds: 1), () => emit(PinCodeInitialState()));
    } else {
      await _pinCodeRepository.savePin(pinCode: event.pinCode);
      emit(PinCodeSuccessfullyChanged());
    }
  }
}
