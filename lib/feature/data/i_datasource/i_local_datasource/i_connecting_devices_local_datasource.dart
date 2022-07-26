import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';

abstract class IConnectingDevicesLocalDataSource {
  Future<ConnectingDevicesModel?> getConnectingDevices();

  Future<void> saveConnectingDevices(ConnectingDevicesModel connectingDevices);
}
