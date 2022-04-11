part of 'pin_code_bloc_bloc.dart';

abstract class PinCodeBlocState extends Equatable {
  const PinCodeBlocState();

  @override
  List<Object> get props => [];
}

class PinCodeBlocInitial extends PinCodeBlocState {
  @override
  List<Object> get props => [];
}

class PinCodeBlocEntered extends PinCodeBlocState {
  final String pinCode;

  const PinCodeBlocEntered({required this.pinCode});

  @override
  List<Object> get props => [pinCode];
}

class PinCodeBlocError extends PinCodeBlocState {
  final String message;

  const PinCodeBlocError({required this.message});

  @override
  List<Object> get props => [message];
}
