// ignore_for_file: cascade_invocations

import 'package:cportal_flutter/core/platform/i_biometric_info.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/pin_code_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/user_datasource/user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/user_datasource/user_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/repositories/biometric_repository.dart';
import 'package:cportal_flutter/feature/data/repositories/contacts_repository_mobile.dart';
import 'package:cportal_flutter/feature/data/repositories/contacts_repository_web.dart';
import 'package:cportal_flutter/feature/data/repositories/filter_repository_mobile.dart';
import 'package:cportal_flutter/feature/data/repositories/filter_repository_web.dart';
import 'package:cportal_flutter/feature/data/repositories/news_repository_mobile.dart';
import 'package:cportal_flutter/feature/data/repositories/news_repository_web.dart';
import 'package:cportal_flutter/feature/data/repositories/pin_code_repository.dart';
import 'package:cportal_flutter/feature/data/repositories/profile_repository_mobile.dart';
import 'package:cportal_flutter/feature/data/repositories/profile_repository_web.dart';
import 'package:cportal_flutter/feature/data/repositories/user_repository_mobile.dart';
import 'package:cportal_flutter/feature/data/repositories/user_repository_web.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_contacts_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_filter_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_profile_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_user_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/biometric_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/check_auth_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_contacts_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_news_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_news_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_filters_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_quastions_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_quastions_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/get_single_profile_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/login_user_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/pin_code_enter_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/search_profile_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLOC/CUBIT.
  sl.registerFactory(() => GetSingleProfileBloc(getSingleProfile: sl()));
  sl.registerFactory(() => AuthBloc(sl(), sl()));
  sl.registerFactory(() => PinCodeBloc(sl()));
  sl.registerFactory(() => BiometricBloc(sl()));
  sl.registerFactory(() => FetchNewsBloc(
        fetchNews: sl(),
        fetchNewsByCategory: sl(),
        fetchQaustions: sl(),
        fetchQuastionsByCategory: sl(),
      ));
  sl.registerFactory(NavigationBarBloc.new);
  sl.registerFactory(() => FilterBloc(fetchFilters: sl()));
  sl.registerFactory(() => ContactsBloc(fetchContacts: sl()));

  // USECASE.
  sl.registerLazySingleton(() => GetSingleProfileUseCase(sl()));
  sl.registerLazySingleton(() => SearchProfileUseCase(sl()));
  sl.registerLazySingleton(() => LoginUserUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));
  sl.registerLazySingleton(() => PinCodeEnterUseCase(sl()));
  sl.registerLazySingleton(() => BiometricUseCase(sl()));
  sl.registerLazySingleton(() => FetchNewsUseCase(sl()));
  sl.registerLazySingleton(() => FetchQuastionsUseCase(sl()));
  sl.registerLazySingleton(() => FetchNewsByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FetchQuastionsByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FetchFiltersUseCase(sl()));
  sl.registerLazySingleton(() => FetchContactsUseCase(sl()));

  // REPOSITORY
  // Произвел адаптацию под web
  // internet_connection_checker не работает с Flutter Web
  // Если Web то инжектируется имплементация без networkInfo
  if (kIsWeb) {
    sl.registerLazySingleton<IProfileRepository>(
      () => ProfileRepositoryWeb(
        remoteDataSource: sl(),
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

  if (kIsWeb) {
    sl.registerLazySingleton<INewsRepository>(
      () => NewsRepositoryWeb(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ),
    );
  } else {
    sl.registerLazySingleton<INewsRepository>(
      () => NewsRepositoryMobile(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );
  }
  if (kIsWeb) {
    sl.registerLazySingleton<IFilterRepository>(
      () => FilterRepositoryWeb(remoteDataSource: sl()),
    );
  } else {
    sl.registerLazySingleton<IFilterRepository>(
      () => FilterRepositoryMobile(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );
  }

  if (kIsWeb) {
    sl.registerLazySingleton<IContactsRepository>(
      () => ContactsRepositoryWeb(remoteDataSource: sl()),
    );
  } else {
    sl.registerLazySingleton<IContactsRepository>(
      () => ContactsRepositoryMobile(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );
  }

  // DATASOURCE.
  sl.registerLazySingleton<IProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(sl()),
  );

  sl.registerLazySingleton<IProfileLocalDataSource>(
    ProfileLocalDataSource.new,
  );

  sl.registerLazySingleton<IUserRemoteDataSource>(
    () => UserRemoteDataSource(sl()),
  );

  sl.registerLazySingleton<IUserLocalDataSource>(
    UserLocalDataSource.new,
  );

  sl.registerLazySingleton<IPinCodeDataSource>(
    PinCodeDataSource.new,
  );

  sl.registerLazySingleton<INewsRemoteDataSource>(
    () => NewsRemoteDataSource(sl(), sl()),
  );

  sl.registerLazySingleton<INewsLocalDataSource>(
    () => NewsLocalDataSource(sl()),
  );
  sl.registerLazySingleton<IFilterRemoteDataSource>(
    () => FilterRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<IFilterLocalDataSource>(
    () => FilterLocalDataSource(sl()),
  );
  sl.registerLazySingleton<IContactsRemoteDataSource>(
    () => ContactsRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<IContactsLocalDataSource>(
    () => ContactsLocalDataSource(sl()),
  );

  // CORE.
  if (!kIsWeb) sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));
  if (!kIsWeb) {
    sl.registerLazySingleton<IBiometricInfo>(() => BiometricInfo(sl()));
  }

  // EXTERNAL.
  sl.registerLazySingleton(InternetConnectionChecker.new);
  sl.registerLazySingleton(Dio.new);
  sl.registerLazySingleton(LocalAuthentication.new);
  sl.registerLazySingleton<HiveInterface>(() => Hive);
}
