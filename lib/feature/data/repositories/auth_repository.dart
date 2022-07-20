import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_auth_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_auth_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_location_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/login/login_request.dart';
import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final IAuthLocalDataSource _authLocalDataSource;
  final IAuthRemoteDataSource _authRemoteDataSource;
  final ILocationRemoteDataSource _locationRemoteDataSource;

  AuthRepository(
    this._authLocalDataSource,
    this._authRemoteDataSource,
    this._locationRemoteDataSource,
  );

  @override
  Future<UserModel?> getUser() async {
    final localUser = await _authLocalDataSource.getCachedUser();

    if (localUser == null) return null;

    try {
      final responseUserModel = await _authRemoteDataSource.getUser(localUser.token);
      final user = responseUserModel.response;
      await _authLocalDataSource.saveUser(user);

      return user;
    } on Exception catch (_) {
      return localUser;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final localUser = await _authLocalDataSource.getCachedUser();

    return localUser != null;
  }

  @override
  Future<UserModel?> logInWithConnectingCode({required String connectingCode}) async {
    try {
      final deviceInfo = await _authLocalDataSource.getDeviceInfo();
      final location = await _locationRemoteDataSource.getLocation();

      final loginRequest = LoginRequest(
        connectingCode: connectingCode,
        device: deviceInfo.name,
        deviceDescription: 'KoApp ${deviceInfo.osInformation}',
        platform: deviceInfo.platform,
        location: location?.fullLocation,
      );
      final responseUserModel = await _authRemoteDataSource.login(loginRequest);
      final user = responseUserModel.response;
      await _authLocalDataSource.saveUser(user);

      return user;
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Future<void> sendConnectingData({required String qrData}) async {
    try {
      return _authRemoteDataSource.sendConnectingData(qrData: qrData);
    } on Exception catch (_) {
      return;
    }
  }

  @override
  Future<void> sendScannedData({required String qrData}) async {
    try {
      final user = await _authLocalDataSource.getCachedUser();

      return _authRemoteDataSource.sendScannedData(qrData: qrData, token: user?.token ?? '');
    } on Exception catch (_) {
      return;
    }
  }
}
