import 'package:equatable/equatable.dart';

abstract class PinCodeState extends Equatable {
  @override
  List<Object> get props => [];
}

class PinCodeInitialState extends PinCodeState {}

class PinCodeEditing extends PinCodeState {
  final String pinCode;

  PinCodeEditing(this.pinCode);

  @override
  List<Object> get props => [pinCode];
}

class PinCodeSuccessfullyChanged extends PinCodeState {}

class PinCodeNotMatch extends PinCodeState {}
