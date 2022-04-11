part of 'pin_code_bloc_bloc.dart';

abstract class PinCodeBlocEvent extends Equatable {
  const PinCodeBlocEvent();

  @override
  List<Object> get props => [];
}

class PinCodeEnteringEvent extends PinCodeBlocEvent {
  final String pinCodeEntering;

  const PinCodeEnteringEvent({required this.pinCodeEntering});
  @override
  List<Object> get props => [pinCodeEntering];
}

class PicCodeEnteredEvent extends PinCodeBlocEvent {
  final String pinCode;

  const PicCodeEnteredEvent({required this.pinCode});
  @override
  List<Object> get props => [pinCode];
}
