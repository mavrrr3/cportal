import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_connecting_devices_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_connecting_devices_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_connecting_devices_repository.dart';
import 'package:dartz/dartz.dart';

class ConnectingDevicesRepository extends IConnectingDevicesRepository {
  final IConnectingDevicesRemoteDataSource _devicesRemoteDataSource;
  final IConnectingDevicesLocalDataSource _devicesLocalDataSource;
  final IUserLocalDataSource _userLocalDataSource;

  ConnectingDevicesRepository(
    this._devicesRemoteDataSource,
    this._devicesLocalDataSource,
    this._userLocalDataSource,
  );

  @override
  Future<Either<Failure, ConnectingDevicesModel>> getConnectingDevices() async {
    try {
      final user = await _userLocalDataSource.getUser();
      final connectingDevices = await _devicesRemoteDataSource.getConnectingDevices(token: user?.token ?? '');
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
      final user = await _userLocalDataSource.getUser();

      return _devicesRemoteDataSource.endOtherSessions(token: user?.token ?? '');
    } on Exception catch (_) {}
  }
}
