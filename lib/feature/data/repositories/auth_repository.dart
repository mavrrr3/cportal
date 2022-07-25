import 'dart:async';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/core/service/device_info_service.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_auth_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_location_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/login/login_params.dart';
import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepository implements IAuthRepository {
  final IUserLocalDataSource _userLocalDataSource;
  final IAuthRemoteDataSource _authRemoteDataSource;
  final ILocationRemoteDataSource _locationRemoteDataSource;
  final DeviceInfoService _deviceInfoService;

  final _authController = StreamController<AuthenticationStatus>.broadcast();

  AuthRepository(
    this._userLocalDataSource,
    this._authRemoteDataSource,
    this._locationRemoteDataSource,
    this._deviceInfoService,
  );

  @override
  Stream<AuthenticationStatus> get status async* {
    yield* _authController.stream;
  }

  @override
  Future<Either<Failure, UserEntity>> logInWithConnectingCode({required String connectingCode}) async {
    try {
      final deviceInfo = await _deviceInfoService.getDeviceInfo();
      final location = await _locationRemoteDataSource.getLocation();

      final loginParams = LogInParams(
        connectingCode: connectingCode,
        device: deviceInfo.name,
        deviceDescription: 'KoApp ${deviceInfo.osInformation}',
        platform: deviceInfo.platform,
        location: location?.fullLocation,
      );
      final user = await _authRemoteDataSource.login(loginParams: loginParams);
      await _userLocalDataSource.saveUser(user);

      return Right(user);
    } on Exception catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _userLocalDataSource.deleteUser();
      _authController.add(AuthenticationStatus.unauthenticated);
    } on Exception catch (_) {}
  }

  void dispose() => _authController.close();
}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }
