import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_connecting_devices_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_connecting_devices_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_connecting_devices_repository.dart';
import 'package:dartz/dartz.dart';

class ConnectingDevicesRepository extends IConnectingDevicesRepository {
  final IConnectingDevicesRemoteDataSource _devicesRemoteDataSource;
  final IConnectingDevicesLocalDataSource _devicesLocalDataSource;

  ConnectingDevicesRepository(
    this._devicesRemoteDataSource,
    this._devicesLocalDataSource,
  );

  @override
  Future<Either<Failure, ConnectingDevicesModel>> getConnectingDevices() async {
    try {
      final connectingDevices = await _devicesRemoteDataSource.getConnectingDevices();
      await _devicesLocalDataSource.saveConnectingDevices(connectingDevices);

      return Right(connectingDevices);
    } on Exception catch (_) {
      final connectingDevices = await _devicesLocalDataSource.getConnectingDevices();

      if (connectingDevices == null) {
        return Left(CacheFailure());
      }

      return Right(connectingDevices);
    }
  }

  @override
  Future<void> endOtherSessions() async {
    try {
      return _devicesRemoteDataSource.endOtherSessions();
    } on Exception catch (_) {}
  }
}
