import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

part 'pin_event.freezed.dart';

@freezed
class PinEvent with _$PinEvent {
  const PinEvent._();

  @Implements<_PinCodeContainer>()
  @With<_InitialStateEmitter>()
  @With<_EnteringStateEmitter>()
  @With<_ErrorStateEmitter>()
  const factory PinEvent.inputPin({required String pinCode}) = _InputPinEvent;
  const factory PinEvent.repeatPin({required String pinCode}) = _RepeatPinEvent;
  const factory PinEvent.createPin({required String pinCode}) = _CreatePinEvent;
  const factory PinEvent.editPin({required String pinCode}) = _EditPinEvent;
  // const factory PinEvent.restore() = _RestorePinEvent;
  // const factory PinEvent.cancel() = _CancelPinEvent;
}

@freezed
class PinState with _$PinState {
  const PinState._();

  // Изначальное состояние ожидаем ввод ПИН-кода.
  const factory PinState.initial() = _InitialPinState;

  // Введение ПИН-кода.
  const factory PinState.enteringPin() = _EnteringPinState;

  // Введение ПИН-кода.
  const factory PinState.repetingPin({
    required String firstPinCode,
  }) = _RepetingPinState;

  // Проверка ПИН-кода.
  const factory PinState.writing({
    required String firstPinCode,
    required String secondPinCode,
  }) = _WritingPinState;

  // ПИН-кода введён.
  const factory PinState.hasPin({required String pinCode}) = _HasPinState;

  // ПИН-код введён неверно.
  const factory PinState.wrong({
    required String pinCode,
    required String wrongPinMessage,
  }) = _WrongPinState;

  // Успех.
  const factory PinState.success({
    required String pinCode,
  }) = _SuccessPinState;

  // При проверке ПИН-кода произошла ошибка.
  const factory PinState.error({
    @Default('Произошла ошибка') String message,
  }) = _ErrorPinState;
}

class PinBloc extends Bloc<PinEvent, PinState> {
  PinBloc() : super(const PinState.initial()) {
    on<PinEvent>(
      (event, emitter) => event.map<Future<void>>(
        inputPin: (event) => _inputPin(event, emitter),
        repeatPin: (event) => _repeatPin(event, emitter),
        createPin: (event) => _createPin(event, emitter),
        editPin: (event) => _editPin(event, emitter),
      ),
      transformer: bloc_concurrency.droppable(),
    );
  }

  Future<void> _inputPin(
      _InputPinEvent event, Emitter<PinState> emitter) async {
    try {
      emitter(event.enteringPin);
    } on Object {
      emitter(event.error(message: 'Непредвиденная ошибка'));
      emitter(event.initial);
      rethrow;
    }
  }

  Future<void> _repeatPin(
      _RepeatPinEvent event, Emitter<PinState> emitter) async {
    try {
      // ...emitter();.
    } on Object {
      rethrow;
    }
  }

  Future<void> _createPin(
      _CreatePinEvent event, Emitter<PinState> emitter) async {
    try {
      // ...emitter();.
    } on Object {
      rethrow;
    }
  }

  Future<void> _editPin(_EditPinEvent event, Emitter<PinState> emitter) async {
    try {
      // ...emitter();.
    } on Object {
      rethrow;
    }
  }
}

/* Контейнеры */

abstract class _PinCodeContainer {
  String get pinCode;
}

/* Миксины эмиттеров */

mixin _InitialStateEmitter on PinEvent {
  // Изначальное состояние [PinState.initial] ожидаем ввод ПИН-кода.
  PinState get initial => const PinState.initial();
}

mixin _EnteringStateEmitter on PinEvent {
  // Введение ПИН-кода [PinState.enteringPin].
  PinState get enteringPin => const PinState.enteringPin();
}

mixin _ErrorStateEmitter on PinEvent {
  // Произошла ошибка [PinState.error].
  PinState error({String? message}) => PinState.error(
        message: message ?? 'Произошла ошибка',
      );
}
