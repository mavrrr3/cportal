import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';
import 'package:dartz/dartz.dart';

abstract class IConnectingDevicesRepository {
  Future<Either<Failure, ConnectingDevicesModel>> getConnectingDevices();

  Future<void> endOtherSessions();
}
