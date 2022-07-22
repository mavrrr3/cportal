import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/auth_datasource/auth_local_datasource.dart';
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
  // TODO: delete this
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepository(
    this._userLocalDataSource,
    this._authRemoteDataSource,
    this._locationRemoteDataSource,
    this._authLocalDataSource,
  );

  @override
  Future<Either<Failure, UserEntity>> logInWithConnectingCode({required String connectingCode}) async {
    try {
      final deviceInfo = await _authLocalDataSource.getDeviceInfo();
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
      print(user.token);
      return Right(user);
    } on Exception catch (_) {
      return Left(ServerFailure());
    }
  }
}
