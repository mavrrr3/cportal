import 'package:cportal_flutter/core/error/server_exception.dart';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_pin_code_local_datasource.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';

import 'package:dartz/dartz.dart';

class PinCodeRepository implements IPinCodeRepository {
  final IPinCodeLocalDataSource localDataSource;

  PinCodeRepository({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> writePin(String pinCode) async {
    try {
      final localePin = await localDataSource.writePin(pinCode);

      return Right(localePin);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<String?> getPin() async {
    return localDataSource.getPin();
  }
}
