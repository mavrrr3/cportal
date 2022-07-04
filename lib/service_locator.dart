// ignore_for_file: cascade_invocations

import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/api/auth_api.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_profile_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_profile_remote_datasource.dart';
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
import 'package:cportal_flutter/feature/domain/usecases/auth_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_contacts_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/news/fetch_news_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/news/fetch_news_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/questions/fetch_questions_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/questions/fetch_questions_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_declarations_filters_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_contacts_filters_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/get_single_profile_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/search_contacts_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/search_profile_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
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
  sl.registerFactory(() => AuthBloc(sl())..add(const CheckLogin()));
  sl.registerFactory(() => ConnectingCodeBloc(sl()));
  sl.registerFactory(() => PinCodeBloc(sl()));
  sl.registerFactory(() => BiometricBloc(sl()));
  sl.registerFactory(() => FetchNewsBloc(
        fetchNews: sl(),
        fetchNewsByCategory: sl(),
      ));
  sl.registerFactory(() => FetchQuestionsBloc(
        fetchQaustions: sl(),
        fetchQuestionsByCategory: sl(),
      ));
  sl.registerFactory(NavigationBarBloc.new);
  sl.registerFactory(() => FilterContactsBloc(fetchFilters: sl()));
  sl.registerFactory(() => ContactsBloc(
        fetchContacts: sl(),
        fetchProfile: sl(),
        searchContacts: sl(),
      ));
  sl.registerFactory(() => FilterDeclarationsBloc(fetchFilters: sl()));

  sl.registerFactory(DeclarationsBloc.new);

  // USECASE.
  sl.registerLazySingleton(() => GetSingleProfileUseCase(sl()));
  sl.registerLazySingleton(() => SearchProfileUseCase(sl()));
  sl.registerLazySingleton(() => FetchNewsUseCase(sl()));
  sl.registerLazySingleton(() => FetchQuestionsUseCase(sl()));
  sl.registerLazySingleton(() => FetchNewsByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FetchQuestionsByCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FetchContactsFiltersUseCase(sl()));
  sl.registerLazySingleton(() => FetchDeclarationsFiltersUseCase(sl()));
  sl.registerLazySingleton(() => FetchContactsUseCase(sl()));
  sl.registerLazySingleton(() => SearchContactsUseCase(sl()));
  sl.registerLazySingleton(() => AuthUseCase(sl(), sl(), sl()));

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
    () => PinCodeRepository(sl()),
  );

  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(sl(), sl()),
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
  sl.registerLazySingleton(LocalAuthentication.new);
  sl.registerLazySingleton<HiveInterface>(() => Hive);
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: AppConfig.apiUri,
        headers: <String, dynamic>{'Authorization': AppConfig.authKey},
      ),
    ),
  );

  // API
  sl.registerLazySingleton(() => AuthApi(sl()));
}
