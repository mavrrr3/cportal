import 'package:cportal_flutter/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IConnectingQrRepository {
  String generateConnectingCode();

  Future<Either<Failure, void>> sendConnectingData(
      {required String connectingCode});

  Future<Either<Failure, void>> sendScannedData(
      {required String connectingCode});
}
