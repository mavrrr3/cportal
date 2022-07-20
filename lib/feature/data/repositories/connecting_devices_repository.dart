import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_auth_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_connecting_devices_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_connecting_devices_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_connecting_devices_repository.dart';

class ConnectingDevicesRepository extends IConnectingDevicesRepository {
  final IConnectingDevicesRemoteDataSource _devicesRemoteDataSource;
  final IConnectingDevicesLocalDataSource _devicesLocalDataSource;
  final IAuthLocalDataSource _authLocalDataSource;

  ConnectingDevicesRepository(
    this._devicesRemoteDataSource,
    this._devicesLocalDataSource,
    this._authLocalDataSource,
  );

  @override
  Future<ConnectingDevicesModel> getConnectingDevices() async {
    try {
      final user = await _authLocalDataSource.getCachedUser();

      final connectingDevices = await _devicesRemoteDataSource.getConnectingDevices(token: user?.token ?? '');
      await _devicesLocalDataSource.saveConnectingDevices(connectingDevices);

      return connectingDevices;
    } on Exception catch (_) {
      final connectingDevices = await _devicesLocalDataSource.getConnectingDevices();

      return connectingDevices ?? ConnectingDevicesModel.empty();
    }
  }

  @override
  Future<void> endOtherSessions() async {
    try {
      final user = await _authLocalDataSource.getCachedUser();

      return _devicesRemoteDataSource.endOtherSessions(token: user?.token ?? '');
    } on Exception catch (_) {}
  }
}
