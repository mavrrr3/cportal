import 'package:cportal_flutter/core/platform/biometric_info.dart';
import 'package:cportal_flutter/core/platform/network_info.dart';
import 'package:cportal_flutter/data/datasources/pin_code_local_datasource.dart';
import 'package:cportal_flutter/data/datasources/profile_datasource/profile_local_datasource.dart';
import 'package:cportal_flutter/data/datasources/profile_datasource/profile_remote_datasource.dart';
import 'package:cportal_flutter/data/datasources/user_datasource/user_local_datasource.dart';
import 'package:cportal_flutter/data/datasources/user_datasource/user_remote_datasource.dart';
import 'package:cportal_flutter/data/repositories/biometric_repository.dart';
import 'package:cportal_flutter/data/repositories/pin_code_repository.dart';
import 'package:cportal_flutter/data/repositories/profile_repository_mobile.dart';
import 'package:cportal_flutter/data/repositories/profile_repository_web.dart';
import 'package:cportal_flutter/data/repositories/user_repository_mobile.dart';
import 'package:cportal_flutter/data/repositories/user_repository_web.dart';
import 'package:cportal_flutter/domain/repositories/i_biometric_repository.dart';
import 'package:cportal_flutter/domain/repositories/i_pin_code_repository.dart';
import 'package:cportal_flutter/domain/repositories/i_profile_repository.dart';
import 'package:cportal_flutter/domain/repositories/i_user_repository.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/biometric_usecase.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/check_auth_usecase.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/get_single_profile_usecase.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/login_user_usecase.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/pin_code_enter_usecase.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/search_profile_usecase.dart';
import 'package:cportal_flutter/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/presentation/bloc/biometric_auth_bloc/biometric_auth_bloc.dart';
import 'package:cportal_flutter/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLOC/CUBIT
  sl.registerFactory(() => GetSingleProfileBloc(getSingleProfile: sl()));
  sl.registerFactory(() => AuthBloc(sl(), sl()));
  sl.registerFactory(() => PinCodeBloc(sl()));
  sl.registerFactory(() => BiometricBloc(sl()));

  // USECASE
  sl.registerLazySingleton(() => GetSingleProfileUseCase(sl()));
  sl.registerLazySingleton(() => SearchProfileUseCase(sl()));
  sl.registerLazySingleton(() => LoginUserUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));
  sl.registerLazySingleton(() => PinCodeEnterUseCase(sl()));
  sl.registerLazySingleton(() => BiometricUseCase(sl()));

  // REPOSITORY
  // Произвел адаптацию под web
  // internet_connection_checker не работает с Flutter Web
  // Если Web то инжектируется имплементация без networkInfo
  if (kIsWeb) {
    sl.registerLazySingleton<IProfileRepository>(
      () => ProfileRepositoryWeb(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ),
    );
  } else {
    sl.registerLazySingleton<IProfileRepository>(
      () => ProfileRepositoryMobile(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );
  }
  if (kIsWeb) {
    sl.registerLazySingleton<IUserRepository>(
      () => UserRepositoryWeb(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ),
    );
  } else {
    sl.registerLazySingleton<IUserRepository>(
      () => UserRepositoryMobile(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );
  }
  sl.registerLazySingleton<IPinCodeRepository>(
    () => PinCodeRepository(
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IBiometricRepository>(
    () => BiometricRepository(biometricInfo: sl()),
  );

  // DATASORCE
  sl.registerLazySingleton<IProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(sl()),
  );

  sl.registerLazySingleton<IProfileLocalDataSource>(
    () => ProfileLocalDataSource(),
  );

  sl.registerLazySingleton<IUserRemoteDataSource>(
    () => UserRemoteDataSource(sl()),
  );

  sl.registerLazySingleton<IUserLocalDataSource>(
    () => UserLocalDataSource(),
  );

  sl.registerLazySingleton<IPinCodeDataSource>(
    () => PinCodeDataSource(),
  );

  // CORE
  if (!kIsWeb) sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));
  if (!kIsWeb) {
    sl.registerLazySingleton<IBiometricInfo>(() => BiometricInfo(sl()));
  }

  // EXTERNAL
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => LocalAuthentication());
}
