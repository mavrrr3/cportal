import 'package:cportal_flutter/core/error/exception.dart';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/data/datasources/pin_code_local_datasource.dart';
import 'package:cportal_flutter/domain/repositories/i_pin_code_repository.dart';

import 'package:dartz/dartz.dart';

class IPinCodeRepositoryWeb implements IPinCodeRepository {
  final IPinCodeDataSource localDataSource;

  IPinCodeRepositoryWeb({
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
}
