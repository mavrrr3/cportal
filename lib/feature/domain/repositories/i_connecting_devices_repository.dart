import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';

abstract class IConnectingDevicesRepository {
  Future<ConnectingDevicesModel> getConnectingDevices();

  Future<void> endOtherSessions();
}
