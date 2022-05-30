import 'package:cportal_flutter/core/usecases/i_usecase.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:equatable/equatable.dart';

class PinCodeEnterUseCase extends IUseCase<String, PinCodeParams> {
  final IPinCodeRepository pinCodeRepository;

  PinCodeEnterUseCase(this.pinCodeRepository);

  @override
  Future<Either<Failure, String>> call(PinCodeParams params) async =>
      pinCodeRepository.writePin(params.pinCode);

  Future<String?> getPin() async => pinCodeRepository.getPin();
}

class PinCodeParams extends Equatable {
  final String pinCode;

  const PinCodeParams({required this.pinCode});
  @override
  List<Object?> get props => [pinCode];
}
