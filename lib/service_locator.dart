import 'package:cportal_flutter/core/platform/network_info.dart';
import 'package:cportal_flutter/data/datasources/profile_local_datasource.dart';
import 'package:cportal_flutter/data/datasources/profile_remote_datasource.dart';
import 'package:cportal_flutter/data/repositories/profile_repository_impl.dart';
import 'package:cportal_flutter/domain/repositories/profile_repository.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/get_single_profile_usecase.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/search_profile_usecase.dart';
import 'package:cportal_flutter/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:cportal_flutter/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLOC/CUBIT
  sl.registerFactory(() => GetSingleProfileBloc(getSingleProfile: sl()));
  sl.registerFactory(() => AuthCubit(sl()));

  // USECASE
  sl.registerLazySingleton(() => GetSingleProfileUseCase(sl()));
  sl.registerLazySingleton(() => SearchProfileUseCase(sl()));

  // REPOSITORY
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(),
  );

  // CORE
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // EXTERNAL
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
