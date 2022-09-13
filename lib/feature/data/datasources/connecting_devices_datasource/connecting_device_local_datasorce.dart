import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_connecting_devices_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';
import 'package:hive/hive.dart';

class ConnectingDevicesLocalDataSource
    implements IConnectingDevicesLocalDataSource {
  final HiveInterface _hive;

  ConnectingDevicesLocalDataSource(this._hive);

  @override
  Future<ConnectingDevicesModel?> getConnectingDevices() async {
    final box =
        await _hive.openBox<ConnectingDevicesModel>('connecting_devices');

    return box.get('connecting_devices');
  }

  @override
  Future<void> saveConnectingDevices(
      ConnectingDevicesModel connectingDevices) async {
    final box =
        await _hive.openBox<ConnectingDevicesModel>('connecting_devices');
    await box.put('connecting_devices', connectingDevices);
  }
}
