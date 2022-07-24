import 'dart:math';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_connecting_qr_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_connecting_qr_repository.dart';
import 'package:dartz/dartz.dart';

class ConnectingQrRepository implements IConnectingQrRepository {
  final IConnectingQrRemoteDataSource _connectingQrRemoteDataSource;
  final IUserLocalDataSource _userLocalDataSource;

  ConnectingQrRepository(
    this._connectingQrRemoteDataSource,
    this._userLocalDataSource,
  );

  @override
  String generateConnectingCode() {
    const charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const length = 20;

    final randomGenerator = Random();
    final codeBuffer = StringBuffer();

    for (var counter = 0; counter < length; counter++) {
      final random = randomGenerator.nextInt(charset.length);
      codeBuffer.write(charset[random]);
    }

    return codeBuffer.toString();
  }

  @override
  Future<Either<Failure, void>> sendConnectingData({required String connectingCode}) async {
    try {
      final result = await _connectingQrRemoteDataSource.sendConnectingData(connectingCode: connectingCode);

      return Right(result);
    } on Exception catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendScannedData({required String connectingCode}) async {
    try {
      final user = await _userLocalDataSource.getUser();
      final result = await _connectingQrRemoteDataSource.sendScannedData(
        connectingCode: connectingCode,
        token: user?.token ?? '',
      );

      return Right(result);
    } on Exception catch (_) {
      return Left(ServerFailure());
    }
  }
}
