import 'package:cportal_flutter/feature/data/models/user/response_user_model.dart';
import 'package:cportal_flutter/feature/domain/entities/device_info.dart';

abstract class IAuthRemoteDataSource {
  Future<ResponseUserModel> login(String connectingCode, DeviceInfo deviceInfo);

  Future<ResponseUserModel> getUser(String token);

  Future<void> sendConnectingData({required String qrData});

  Future<void> sendScannedData({required String qrData, required String token});
}
