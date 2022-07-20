import 'package:cportal_flutter/feature/data/models/location/location.dart';

abstract class ILocationRemoteDataSource {
  Future<Location?> getLocation();
}
