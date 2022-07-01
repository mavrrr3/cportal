// ignore_for_file: cascade_invocations

import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_remote_datasource.dart';
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
import 'package:cportal_flutter/feature/data/repositories/auth_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_contacts_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_filter_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_profile_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_contacts_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_news_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_news_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_filters_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_quastions_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_quastions_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/get_single_profile_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/search_contacts_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/search_profile_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
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
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl())..add(const CheckLogin()));
  sl.registerFactory(() => ConnectingCodeBloc(sl()));
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
  sl.registerFactory(() => ContactsBloc(
        fetchContacts: sl(),
        fetchProfile: sl(),
        searchContacts: sl(),
      ));

  // USECASE.
  sl.registerLazySingleton(() => GetSingleProfileUseCase(sl()));
  sl.registerLazySingleton(() => SearchProfileUseCase(sl()));
  sl.registerLazySingleton(() => FetchNewsUseCase(sl()));
  sl.registerLazySingleton(() => FetchQuastionsUseCase(sl()));
  sl.registerLazySingleton(() => FetchNewsByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FetchQuastionsByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FetchFiltersUseCase(sl()));
  sl.registerLazySingleton(() => FetchContactsUseCase(sl()));
  sl.registerLazySingleton(() => SearchContactsUseCase(sl()));

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
  // if (kIsWeb) {
  //   sl.registerLazySingleton<IUserRepository>(
  //     () => UserRepositoryWeb(
  //       remoteDataSource: sl(),
  //       localDataSource: sl(),
  //     ),
  //   );
  // } else {
  //   sl.registerLazySingleton<IUserRepository>(
  //     () => UserRepositoryMobile(
  //       remoteDataSource: sl(),
  //       localDataSource: sl(),
  //       networkInfo: sl(),
  //     ),
  //   );
  // }
  sl.registerLazySingleton<IPinCodeRepository>(
    PinCodeRepository.new,
  );

  sl.registerLazySingleton<IAuthRepository>(
    AuthRepository.new,
  );

  sl.registerLazySingleton<IBiometricRepository>(
    () => BiometricRepository(sl()),
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
    () => ProfileRemoteDataSource(sl(), sl()),
  );

  sl.registerLazySingleton<IProfileLocalDataSource>(
    ProfileLocalDataSource.new,
  );
  sl.registerLazySingleton<INewsRemoteDataSource>(
    () => NewsRemoteDataSource(sl(), sl()),
  );

  sl.registerLazySingleton<INewsLocalDataSource>(
    () => NewsLocalDataSource(sl()),
  );
  sl.registerLazySingleton<IContactsRemoteDataSource>(
    () => ContactsRemoteDataSource(sl(), sl()),
  );
  sl.registerLazySingleton<IContactsLocalDataSource>(
    () => ContactsLocalDataSource(sl()),
  );
  sl.registerLazySingleton<IFilterRemoteDataSource>(
    () => FilterRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<IFilterLocalDataSource>(
    () => FilterLocalDataSource(sl()),
  );

  // CORE.
  if (!kIsWeb) sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));
  // EXTERNAL.
  sl.registerLazySingleton(InternetConnectionChecker.new);
  sl.registerLazySingleton(Dio.new);
  sl.registerLazySingleton(LocalAuthentication.new);
  sl.registerLazySingleton<HiveInterface>(() => Hive);
}
