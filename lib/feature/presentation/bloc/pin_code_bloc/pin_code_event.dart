import 'package:equatable/equatable.dart';

abstract class PinCodeEvent extends Equatable {}

class CreatePinCode extends PinCodeEvent {
  final String pinCode;

  CreatePinCode(this.pinCode);

  @override
  List<Object?> get props => [pinCode];
}

class RepeatPinCode extends PinCodeEvent {
  final String pinCode;

  RepeatPinCode(this.pinCode);

  @override
  List<Object?> get props => [pinCode];
}
