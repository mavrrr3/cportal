import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';

abstract class IConnectingDevicesRemoteDataSource {
  Future<ConnectingDevicesModel> getConnectingDevices({required String token});
}
