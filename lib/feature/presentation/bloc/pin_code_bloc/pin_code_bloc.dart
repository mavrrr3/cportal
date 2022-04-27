import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cportal_flutter/feature/domain/usecases/users_usecases/pin_code_enter_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/material.dart';

enum PinCodeInputEnum {
  input,
  inputing,
  wrongInput,
  create,
  wrong,
  repeat,
  edit,
  editing,
  wrongEdit,
  error,
  done,
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
    on<EditPinCodeCheckEvent>(
      _hasEditPinCode,
      transformer: bloc_concurrency.sequential(),
    );

    on<ChangedPinCode>(
      _onCreate,
      transformer: bloc_concurrency.sequential(),
    );
    on<EditPinCodeSubmit>(
      _onEditSubmit,
      transformer: bloc_concurrency.sequential(),
    );
    on<InputPinCodeSubmit>(
      _onInputSubmit,
      transformer: bloc_concurrency.sequential(),
    );
    on<RepeatPinCodeSubmit>(
      _onRepeatSubmit,
      transformer: bloc_concurrency.sequential(),
    );
    on<CreatePinCodeSubmit>(
      _onCreateSubmit,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr<void> _hasPinCode(
    PinCodeCheckEvent event,
    Emitter<PinCodeState> emit,
  ) async {
    if (kDebugMode) log(event.toString());

    final pinCodeFromHive = await pinCodeEnter.getPin();

    if (pinCodeFromHive == null) {
      emit(state.copyWith(status: PinCodeInputEnum.create));
    } else {
      emit(state.copyWith(
        pinCode: pinCodeFromHive,
        status: PinCodeInputEnum.done,
      ));
    }
  }

  FutureOr<void> _hasEditPinCode(
    EditPinCodeCheckEvent event,
    Emitter<PinCodeState> emit,
  ) async {
    if (kDebugMode) log(event.toString());

    emit(state.copyWith(status: PinCodeInputEnum.create));
  }

  FutureOr<void> _onCreate(
    ChangedPinCode event,
    Emitter<PinCodeState> emit,
  ) async {
    if (kDebugMode) log(event.pinCode.toString());
    log('=========Такой эвент $event');

    emit(state.copyWith(
      status: getStatus(event.status),
      pinCode: event.pinCode,
    ));
  }

  PinCodeInputEnum getStatus(PinCodeInputEnum status) {
    return status == PinCodeInputEnum.create
        ? PinCodeInputEnum.create
        : status == PinCodeInputEnum.wrongInput
            ? PinCodeInputEnum.create
            : PinCodeInputEnum.repeat;
  }

  FutureOr<void> _onInputSubmit(
    InputPinCodeSubmit event,
    Emitter<PinCodeState> emit,
  ) async {
    log('=========Такой эвент $event');

    final pinCodeFromHive = await pinCodeEnter.getPin();
    log('=========Такой новый пин ${event.pinCode} Такой из базы пин $pinCodeFromHive');

    if (pinCodeFromHive == event.pinCode) {
      emit(state.copyWith(status: PinCodeInputEnum.done));
    } else {
      emit(state.copyWith(status: PinCodeInputEnum.wrongInput));
    }
  }

  FutureOr<void> _onEditSubmit(
    EditPinCodeSubmit event,
    Emitter<PinCodeState> emit,
  ) async {
    log('=========Такой эвент $event');

    final failureOrPinCode =
        await pinCodeEnter(PinCodeParams(pinCode: event.pinCode));

    log(failureOrPinCode.toString());

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
  }

  FutureOr<void> _onRepeatSubmit(
    RepeatPinCodeSubmit event,
    Emitter<PinCodeState> emit,
  ) async {
    log('=========Такой эвент $event');
    final pinCodeFromHive = await pinCodeEnter.getPin();
    log('=========Такой новый пин ${event.pinCode} Такой из базы пин $pinCodeFromHive');

    if (event.pinCode == pinCodeFromHive) {
      emit(state.copyWith(status: PinCodeInputEnum.done));
    } else {
      emit(state.copyWith(status: PinCodeInputEnum.wrong));
    }
  }

  FutureOr<void> _onCreateSubmit(
    CreatePinCodeSubmit event,
    Emitter<PinCodeState> emit,
  ) async {
    log('=========Такой эвент $event');
    emit(state.copyWith(status: PinCodeInputEnum.create));

    final pinCodeFromHive = await pinCodeEnter.getPin();

    if (pinCodeFromHive == null) {
      final failureOrPinCode =
          await pinCodeEnter(PinCodeParams(pinCode: event.pinCode));

      log('Из кэша +++' + failureOrPinCode.toString());

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
      if (event.pinCode == pinCodeFromHive) {
        emit(state.copyWith(status: PinCodeInputEnum.done));
      } else {
        emit(state.copyWith(status: PinCodeInputEnum.wrong));
      }
    }
  }
}

class PinCodeState {
  final String pinCode;
  final PinCodeInputEnum status;

  bool get isWrongPin =>
      status == PinCodeInputEnum.error || status == PinCodeInputEnum.wrong;

  Future<String> cleanField(TextEditingController textController) {
    return status == PinCodeInputEnum.wrong || status == PinCodeInputEnum.repeat
        ? Future.delayed(
            const Duration(milliseconds: 1000),
            () => textController.text = '',
          )
        : Future.delayed(
            const Duration(milliseconds: 100),
            () => textController.text = '',
          );
  }

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

  @override
  String toString() {
    return 'Стейт $status';
  }
}

abstract class PinCodeEvent extends Equatable {
  const PinCodeEvent();

  @override
  List<Object> get props => [];
}

class PinCodeCheckEvent extends PinCodeEvent {}

class EditPinCodeCheckEvent extends PinCodeEvent {}

class ChangedPinCode extends PinCodeEvent {
  final String pinCode;
  final PinCodeInputEnum status;
  const ChangedPinCode({required this.pinCode, required this.status});
}

class EditPinCodeSubmit extends PinCodeEvent {
  final String pinCode;
  final PinCodeInputEnum status;
  const EditPinCodeSubmit({required this.pinCode, required this.status});
}

class RepeatPinCodeSubmit extends PinCodeEvent {
  final String pinCode;
  final PinCodeInputEnum status;
  const RepeatPinCodeSubmit({required this.pinCode, required this.status});
}

class InputPinCodeSubmit extends PinCodeEvent {
  final String pinCode;
  final PinCodeInputEnum status;
  const InputPinCodeSubmit({required this.pinCode, required this.status});
}

class CreatePinCodeSubmit extends PinCodeEvent {
  final String pinCode;
  final PinCodeInputEnum status;
  const CreatePinCodeSubmit({required this.pinCode, required this.status});
}
