import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/pin_code_enter_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

enum PinCodeInputEnum {
  create,
  repeat,
  input,
  error,
  done,
  wrong,
  wrongRepeat,
  writingCreate,
  writingRepeat,
  wrongInput,
  writingInput,
}

class PinCodeBloc extends Bloc<PinCodeEvent, PinCodeState> {
  PinCodeEnterUseCase pinCodeEnter;
  PinCodeBloc(
    this.pinCodeEnter,
  ) : super(PinCodeState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<PinCodeCheckEvent>(
      _hasPinCode,
      transformer: bloc_concurrency.sequential(),
    );

    on<PinCodeChange>(_onChange, transformer: bloc_concurrency.sequential());

    on<PinCodeSubmit>(_onSubmit, transformer: bloc_concurrency.sequential());
  }

  FutureOr<void> _hasPinCode(
    PinCodeCheckEvent event,
    Emitter<PinCodeState> emit,
  ) async {
    if (kDebugMode) log(event.toString());

    final pinCodeOrNull = await pinCodeEnter.getPin();

    if (pinCodeOrNull == null) {
      emit(state.copyWith(status: PinCodeInputEnum.create));
    } else {
      emit(state.copyWith(
        pinCode: pinCodeOrNull,
        status: PinCodeInputEnum.input,
      ));
    }
  }

  FutureOr<void> _onChange(
    PinCodeChange event,
    Emitter<PinCodeState> emit,
  ) async {
    if (kDebugMode) log(event.pinCode.toString());

    emit(state.copyWith(
      status: getStatus(event.status),
      pinCode: event.pinCode,
    ));
  }

  PinCodeInputEnum getStatus(PinCodeInputEnum status) {
    if (status == PinCodeInputEnum.create ||
        status == PinCodeInputEnum.writingCreate) {
      return PinCodeInputEnum.writingCreate;
    } else if (status == PinCodeInputEnum.repeat ||
        status == PinCodeInputEnum.writingRepeat ||
        status == PinCodeInputEnum.wrongRepeat) {
      return PinCodeInputEnum.writingRepeat;
    } else {
      return PinCodeInputEnum.writingInput;
    }
  }

  FutureOr<void> _onSubmit(
    PinCodeSubmit event,
    Emitter<PinCodeState> emit,
  ) async {
    emit(state.copyWith(status: PinCodeInputEnum.create));

    final pinCodeOrNull = await pinCodeEnter.getPin();

    if (pinCodeOrNull == null) {
      final failureOrPinCode =
          await pinCodeEnter(PinCodeParams(pinCode: event.pinCode));

      failureOrPinCode.fold(
        (failure) {
          emit(
            state.copyWith(status: PinCodeInputEnum.error),
          );
        },
        (pinCode) {
          emit(state.copyWith(status: PinCodeInputEnum.repeat));
        },
      );
    } else {
      if (event.pinCode == pinCodeOrNull) {
        emit(state.copyWith(status: PinCodeInputEnum.done));
      } else {
        event.status == PinCodeInputEnum.writingInput
            ? emit(state.copyWith(status: PinCodeInputEnum.wrongInput))
            : emit(state.copyWith(status: PinCodeInputEnum.wrongRepeat));
      }
    }
  }
}

class PinCodeState {
  final String pinCode;
  final PinCodeInputEnum status;

  bool get isWrongPin =>
      status == PinCodeInputEnum.error ||
      status == PinCodeInputEnum.wrong ||
      status == PinCodeInputEnum.wrongRepeat ||
      status == PinCodeInputEnum.wrongInput;

  bool get doesItNeedToClean =>
      status == PinCodeInputEnum.repeat ||
      status == PinCodeInputEnum.create ||
      status == PinCodeInputEnum.writingCreate ||
      status == PinCodeInputEnum.wrong ||
      status == PinCodeInputEnum.wrongRepeat;

  PinCodeState({
    this.pinCode = '',
    this.status = PinCodeInputEnum.create,
  });

  PinCodeState copyWith({
    String? pinCode,
    PinCodeInputEnum? status,
  }) {
    return PinCodeState(
      pinCode: pinCode ?? this.pinCode,
      status: status ?? this.status,
    );
  }
}

abstract class PinCodeEvent extends Equatable {
  const PinCodeEvent();

  @override
  List<Object> get props => [];
}

class PinCodeCheckEvent extends PinCodeEvent {}

class PinCodeChange extends PinCodeEvent {
  final String pinCode;
  final PinCodeInputEnum status;
  const PinCodeChange({required this.pinCode, required this.status});
}

class PinCodeSubmit extends PinCodeEvent {
  final String pinCode;
  final PinCodeInputEnum status;
  const PinCodeSubmit({required this.pinCode, required this.status});
}
