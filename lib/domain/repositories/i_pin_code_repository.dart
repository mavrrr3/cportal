import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

abstract class IPinCodeRepository {
  Future<Either<Failure, String>> writePin(String pinCode);
}
