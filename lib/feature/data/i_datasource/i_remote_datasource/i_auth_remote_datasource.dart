import 'package:cportal_flutter/feature/data/models/login/login_request.dart';
import 'package:cportal_flutter/feature/data/models/user/response_user_model.dart';

abstract class IAuthRemoteDataSource {
  Future<ResponseUserModel> login(LoginRequest loginRequest);

  Future<ResponseUserModel> getUser(String token);

  Future<void> sendConnectingData({required String qrData});

  Future<void> sendScannedData({required String qrData, required String token});
}
