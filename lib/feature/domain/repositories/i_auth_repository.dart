import 'package:cportal_flutter/feature/data/models/user/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel?> logInWithConnectingCode({required String connectingCode});

  Future<void> sendConnectingData({required String qrData});

  Future<void> sendScannedData({required String qrData});

  Future<UserModel?> getUser();

  Future<bool> isAuthenticated();
}
