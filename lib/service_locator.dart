import 'package:cportal_flutter/data/datasources/user_remote_datasource.dart';
import 'package:cportal_flutter/data/repositories/user_repository_impl.dart';
import 'package:cportal_flutter/domain/repositories/user_repository.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/get_single_user_usecase.dart';
import 'package:cportal_flutter/domain/usecases/users_usecases/search_users_usecase.dart';
import 'package:cportal_flutter/presentation/bloc/user_bloc/get_single_user_bloc/get_single_user_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLOC
  sl.registerFactory(() => GetSingleUserBloc(getSingleUser: sl()));

  // USECASE
  sl.registerLazySingleton(() => GetSingleUserUseCase(sl()));
  sl.registerLazySingleton(() => SearchUsersUseCase(sl()));

  // REPOSITORY
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );

  // CORE

  // EXTERNAL
}
