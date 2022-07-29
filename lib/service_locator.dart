import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/core/interceptor/auth_key_interceptor.dart';
import 'package:cportal_flutter/core/service/auth_service.dart';
import 'package:cportal_flutter/core/interceptor/token_interceptor.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/core/service/device_info_service.dart';
import 'package:cportal_flutter/core/service/dio_factory.dart';
import 'package:cportal_flutter/feature/data/datasources/auth_datasource/auth_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/connecting_devices_datasource/connecting_device_local_datasorce.dart';
import 'package:cportal_flutter/feature/data/datasources/connecting_devices_datasource/connecting_devices_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/connecting_qr_datasource/connecting_qr_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/contacts_datasource/contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/location_datasource/location_remote_datasorce.dart';
import 'package:cportal_flutter/feature/data/datasources/main_search_datasource/main_search_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/main_search_datasource/main_search_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/profile_datasource/profile_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/user_datasource/user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/user_datasource/user_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_connecting_devices_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_contacts_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_filter_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_main_search_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_profile_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_auth_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_connecting_devices_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_connecting_qr_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_contacts_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_filter_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_location_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_main_search_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_profile_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_user_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/repositories/biometric_repository.dart';
import 'package:cportal_flutter/feature/data/repositories/connecting_devices_repository.dart';
import 'package:cportal_flutter/feature/data/repositories/connecting_qr_repository.dart';
import 'package:cportal_flutter/feature/data/repositories/contacts_repository_mobile.dart';
import 'package:cportal_flutter/feature/data/repositories/contacts_repository_web.dart';
import 'package:cportal_flutter/feature/data/repositories/filter_repository_mobile.dart';
import 'package:cportal_flutter/feature/data/repositories/filter_repository_web.dart';
import 'package:cportal_flutter/feature/data/repositories/main_search_repository.dart';
import 'package:cportal_flutter/feature/data/repositories/news_repository_mobile.dart';
import 'package:cportal_flutter/feature/data/repositories/news_repository_web.dart';
import 'package:cportal_flutter/feature/data/repositories/pin_code_repository.dart';
import 'package:cportal_flutter/feature/data/repositories/profile_repository_mobile.dart';
import 'package:cportal_flutter/feature/data/repositories/profile_repository_web.dart';
import 'package:cportal_flutter/feature/data/repositories/auth_repository.dart';
import 'package:cportal_flutter/feature/data/repositories/user_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_biometric_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_connecting_devices_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_connecting_qr_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_contacts_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_filter_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_main_search_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_pin_code_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_profile_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_user_repository.dart';
import 'package:cportal_flutter/feature/domain/usecases/auth/has_auth_credentials_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/auth/log_in_with_biometrics_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/auth/log_in_with_connecting_code_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/auth/log_in_with_pin_code_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/connecting_qr/generate_connecting_code_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/connecting_qr/send_connecting_data_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/connecting_qr/send_scanned_data_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/contacts/fetch_contacts_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/main_search/main_search_add_to_memory_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/main_search/main_search_get_from_memory_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/main_search/main_search_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/news/fetch_news_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/news/fetch_news_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/news/get_single_news_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/questions/fetch_questions_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/questions/fetch_questions_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/declaration/fetch_declarations_filters_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/contacts/fetch_contacts_filters_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/profile/get_single_profile_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/contacts/search_contacts_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/profile/search_profile_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/questions/get_single_question_usecase.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connectinng_devices_bloc/connecting_devices_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_qr_bloc/connecting_qr_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_bloc.dart';

final sl = GetIt.instance;

// ignore: long-method
Future<void> init() async {
  // BLOC/CUBIT.
  sl
    ..registerFactory(() => GetSingleProfileBloc(getSingleProfile: sl()))
    ..registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()))
    ..registerFactory(() => GetSingleNewsBloc(getSingleNews: sl()))
    ..registerFactory(() => GetSingleQuestionBloc(getSingleQuestion: sl()))
    ..registerFactory(() => ConnectingCodeBloc(sl()))
    ..registerFactory(() => PinCodeBloc(sl()))
    ..registerFactory(() => BiometricBloc(sl()))
    ..registerFactory(() => FetchNewsBloc(
          fetchNews: sl(),
          fetchNewsByCategory: sl(),
        ))
    ..registerFactory(() => FetchQuestionsBloc(
          fetchQaustions: sl(),
          fetchQuestionsByCategory: sl(),
        ))
    ..registerFactory(NavigationBarBloc.new)
    ..registerFactory(() => FilterContactsBloc(fetchFilters: sl()))
    ..registerFactory(() => ContactsBloc(
          fetchContacts: sl(),
          fetchProfile: sl(),
          searchContacts: sl(),
        ))
    ..registerFactory(() => FilterDeclarationsBloc(fetchFilters: sl()))
    ..registerFactory(DeclarationsBloc.new)
    ..registerFactory(() => ConnectingQrBloc(sl(), sl(), sl()))
    ..registerFactory(() => ConnectingDevicesBloc(sl(), sl()))
    ..registerFactory(() => MainSearchBloc(sl(), sl(), sl()))

    // USECASE.
    ..registerLazySingleton(() => GetSingleProfileUseCase(sl()))
    ..registerLazySingleton(() => GetSingleNewsUseCase(sl()))
    ..registerLazySingleton(() => GetSingleQuestionUseCase(sl()))
    ..registerLazySingleton(() => SearchProfileUseCase(sl()))
    ..registerLazySingleton(() => FetchNewsUseCase(sl()))
    ..registerLazySingleton(() => FetchQuestionsUseCase(sl()))
    ..registerLazySingleton(() => FetchNewsByCategoryUseCase(sl()))
    ..registerLazySingleton(() => FetchQuestionsByCategoryUseCase(sl()))
    ..registerLazySingleton(() => FetchContactsFiltersUseCase(sl()))
    ..registerLazySingleton(() => FetchDeclarationsFiltersUseCase(sl()))
    ..registerLazySingleton(() => FetchContactsUseCase(sl()))
    ..registerLazySingleton(() => SearchContactsUseCase(sl()))
    ..registerLazySingleton(() => HasAuthCredentialsUseCase(sl(), sl()))
    ..registerLazySingleton(() => LogInWithConnectingCodeUseCase(sl()))
    ..registerLazySingleton(() => LogInWithPinCodeUseCase(sl(), sl()))
    ..registerLazySingleton(() => LogInWithBiometricsUseCase(sl(), sl()))
    ..registerLazySingleton(() => GenerateConnectingCodeUseCase(sl()))
    ..registerLazySingleton(() => SendScannedDataUseCase(sl()))
    ..registerLazySingleton(() => SendConnectingDataUseCase(sl()))
    ..registerLazySingleton(() => MainSearchUseCase(sl()))
    ..registerLazySingleton(() => MainSearchAddToMemoryUseCase(sl()))
    ..registerLazySingleton(() => MainSearchGetFromMemoryUseCase(sl()));

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
  sl
    ..registerLazySingleton<IPinCodeRepository>(
      () => PinCodeRepository(sl()),
    )
    ..registerLazySingleton<IAuthRepository>(
      () => AuthRepository(sl(), sl(), sl(), sl()),
    )
    ..registerLazySingleton<IBiometricRepository>(
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
  sl
    ..registerLazySingleton<IConnectingDevicesRepository>(
      () => ConnectingDevicesRepository(sl(), sl()),
    )
    ..registerLazySingleton<IUserRepository>(
      () => UserRepository(sl(), sl()),
    )
    ..registerLazySingleton<IConnectingQrRepository>(
      () => ConnectingQrRepository(sl()),
    )
    ..registerLazySingleton<IMainSearchRepository>(
      () => MainSearchRepository(remoteDataSource: sl(), localDataSource: sl()),
    )

    // DATASOURCE.
    ..registerLazySingleton<IProfileRemoteDataSource>(
      () => ProfileRemoteDataSource(sl(), sl()),
    )
    ..registerLazySingleton<IProfileLocalDataSource>(
      ProfileLocalDataSource.new,
    )
    ..registerLazySingleton<INewsRemoteDataSource>(
      () => NewsRemoteDataSource(sl(), sl()),
    )
    ..registerLazySingleton<INewsLocalDataSource>(
      () => NewsLocalDataSource(sl()),
    )
    ..registerLazySingleton<IContactsRemoteDataSource>(
      () => ContactsRemoteDataSource(sl(), sl()),
    )
    ..registerLazySingleton<IContactsLocalDataSource>(
      () => ContactsLocalDataSource(sl()),
    )
    ..registerLazySingleton<IFilterRemoteDataSource>(
      () => FilterRemoteDataSource(sl(), sl()),
    )
    ..registerLazySingleton<IFilterLocalDataSource>(
      () => FilterLocalDataSource(sl()),
    )
    ..registerLazySingleton<IAuthRemoteDataSource>(
      () => AuthRemoteDataSource(sl<Dio>(instanceName: 'initial')),
    )
    ..registerLazySingleton<IConnectingDevicesRemoteDataSource>(
      () => ConnectingDevicesRemoteDataSource(sl()),
    )
    ..registerLazySingleton<IConnectingDevicesLocalDataSource>(
      () => ConnectingDevicesLocalDataSource(sl()),
    )
    ..registerLazySingleton<ILocationRemoteDataSource>(
      () => LocationRemoteDataSource(Dio()),
    )
    ..registerLazySingleton<IUserLocalDataSource>(
      () => UserLocalDataSource(sl()),
    )
    ..registerLazySingleton<IUserRemoteDataSource>(
      () => UserRemoteDataSource(sl()),
    )
    ..registerLazySingleton<IConnectingQrRemoteDataSource>(
      () => ConnectingQrRemoteDataSource(sl()),
    )
    ..registerLazySingleton<IMainSearchRemoteDataSource>(
      () => MainSearchRemoteDataSource(sl()),
    )
    ..registerLazySingleton<IMainSearchLocalDataSource>(
      () => MainSearchLocalDatasource(sl()),
    );

  // CORE.
  if (!kIsWeb) sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));
  sl
    ..registerLazySingleton<DeviceInfoPlugin>(DeviceInfoPlugin.new)
    ..registerLazySingleton<DeviceInfoService>(() => DeviceInfoService(sl()))
    ..registerLazySingleton<AuthService>(() => AuthService(sl()))
    ..registerLazySingleton<DioFactory>(DioFactory.new)
    // EXTERNAL.
    ..registerLazySingleton(InternetConnectionChecker.new)
    ..registerLazySingleton(LocalAuthentication.new)
    ..registerLazySingleton<HiveInterface>(() => Hive)
    ..registerLazySingleton<Dio>(
      () => sl<DioFactory>().create(
        baseUrl: AppConfig.apiUri,
        interceptors: [
          AuthKeyInterceptor(AppConfig.authKey),
        ],
      ),
      instanceName: 'initial',
    )
    ..registerLazySingleton<Dio>(
      () => sl<Dio>(instanceName: 'initial')
        ..interceptors.add(
          TokenInterceptor(sl(), sl()),
        ),
    );
}
