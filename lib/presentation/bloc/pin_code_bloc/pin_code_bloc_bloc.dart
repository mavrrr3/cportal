import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pin_code_bloc_event.dart';
part 'pin_code_bloc_state.dart';

class PinCodeBlocBloc extends Bloc<PinCodeBlocEvent, PinCodeBlocState> {
  PinCodeBlocBloc() : super(PinCodeBlocInitial()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<PinCodeEnteringEvent>(_onChange);
    on<PicCodeEnteredEvent>(_onEntered);
  }

  FutureOr<void> _onChange(
    PinCodeEnteringEvent event,
    Emitter<PinCodeBlocState> emit,
  ) {
    if (event.pinCodeEntering.length != 4) emit(PinCodeBlocInitial());
  }

  FutureOr<void> _onEntered(
    PicCodeEnteredEvent event,
    Emitter<PinCodeBlocState> emit,
  ) {}
}
