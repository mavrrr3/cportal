import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:equatable/equatable.dart';

import 'package:cportal_flutter/domain/usecases/users_usecases/pin_code_enter_usecase.dart';
import 'package:flutter/foundation.dart';

part 'pin_code_event.dart';
part 'pin_code_state.dart';

class PinCodeBloc extends Bloc<PinCodeBlocEvent, PinCodeState> {
  PinCodeEnterUseCase pinCodeEnter;
  PinCodeBloc(
    this.pinCodeEnter,
  ) : super(PinCodeInitialState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<PinCodeCheckEvent>(_hasPinCode);
    on<PicCodeEnteredEvent>(_onEntered);
    on<PinCodeEnteringEvent>((event, emit) {
      emit(const PinCodeEnterState());
    });
  }

  FutureOr<void> _hasPinCode(
    PinCodeCheckEvent event,
    Emitter<PinCodeState> emit,
  ) async {
    if (kDebugMode) log(event.toString());

    final pinCodeOrNull = await pinCodeEnter.getPin();

    if (pinCodeOrNull == null) {
      emit(const PinCodeCreateState());
    } else {
      emit(const PinCodeEnterState());
    }
  }

  FutureOr<void> _onEntered(
    PicCodeEnteredEvent event,
    Emitter<PinCodeState> emit,
  ) async {
    final pinCodeOrNull = await pinCodeEnter.getPin();

    if (pinCodeOrNull == null) {
      log('В кеше пин равен нулу отправляю на сохранение в кеш' +
          event.pinCode);

      final failureOrPinCode =
          await pinCodeEnter(PinCodeParams(pinCode: event.pinCode));

      failureOrPinCode.fold(
        (failure) {
          emit(
            PinCodeErrorState(message: _mapFailureToMessage(failure)),
          );
        },
        (pinCode) {
          emit(const PinCodeRepeatState());
        },
      );
    } else {
      if (pinCodeOrNull == event.pinCode) {
        final failureOrPinCode =
            await pinCodeEnter(PinCodeParams(pinCode: event.pinCode));

        failureOrPinCode.fold(
          (failure) {
            emit(
              PinCodeErrorState(message: _mapFailureToMessage(failure)),
            );
          },
          (pinCode) {
            emit(PinCodeEnteredState(pinCode: pinCode));
          },
        );
      } else {
        emit(const PinCodeErrorState(message: 'Не совпадает ПИН'));
      }
    }

    if (kDebugMode) log('PinCodeState: ' + state.toString());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Ошибка на сервере';
      case CacheFailure:
        return 'Ошибка обработки кэша';
      default:
        return 'Unexpected Error';
    }
  }
}
