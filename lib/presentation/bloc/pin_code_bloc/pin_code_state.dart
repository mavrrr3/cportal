part of 'pin_code_bloc.dart';

abstract class PinCodeState extends Equatable {
  const PinCodeState();

  @override
  List<Object> get props => [];
}

class PinCodeInitialState extends PinCodeState {
  @override
  List<Object> get props => [];
}

class PinCodeRepeatState extends PinCodeState {
  const PinCodeRepeatState();
  @override
  List<Object> get props => [];
}

class PinCodeEnterState extends PinCodeState {
  const PinCodeEnterState();
  @override
  List<Object> get props => [];
}

class PinCodeCreateState extends PinCodeState {
  const PinCodeCreateState();
  @override
  List<Object> get props => [];
}

class PinCodeEnteredState extends PinCodeState {
  final String pinCode;

  bool get isGoToRepeat => pinCode == 'repeat';

  const PinCodeEnteredState({required this.pinCode});

  @override
  List<Object> get props => [pinCode];
}

class PinCodeErrorState extends PinCodeState {
  final String message;

  const PinCodeErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
