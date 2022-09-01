import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/util/app_bloc_observer.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_device_model.dart';
import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';
import 'package:cportal_flutter/feature/data/models/contacts_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/declaration_document_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/declaration_info_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/declaration_step_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/task_status_enum.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/description_enum.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/task_card_model.dart';
import 'package:cportal_flutter/feature/data/models/documents/tasks/tasks_response_model.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/data/models/new_employee_model.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:cportal_flutter/feature/data/models/user/contact_model.dart';
import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:cportal_flutter/feature/domain/entities/device/device_platform.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/finger_print_support_bloc/finger_print_support_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/is_finger_print_enabled_bloc/is_finger_print_enabled_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/turn_off_finger_print_bloc/turn_off_finger_print_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connectinng_devices_bloc/connecting_devices_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_visibility_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/main_search_bloc/main_search_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/new_employee_bloc/fetch_new_employee_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/service_locator.dart' as di;
import 'package:cportal_flutter/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:responsive_framework/responsive_framework.dart';

import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/declarations_bloc/declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_bloc.dart';

import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_card_model.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runZonedGuarded<void>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await AppConfig.load();
      await di.init();

      await Hive.initFlutter();
      _hiveAdaptersInit();

      await SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
      );

      // TODO change to UPDATE to 9 version BLoC
      // ignore: deprecated_member_use
      BlocOverrides.runZoned(
        () => runApp(const Main()),
        blocObserver: AppBlocObserver.instance(),
        eventTransformer: bloc_concurrency.sequential<Object?>(),
      );
    },
    (error, stackTrace) {
      if (kDebugMode) {
        print('Caught Framework error');
        // В debug режиме выводим ошибки в консоль.
        FlutterError.dumpErrorToConsole(
          FlutterErrorDetails(exception: error),
        );
      } else {
        Zone.current.handleUncaughtError(error, stackTrace);
      }
    },
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: listOfBlocs(),
      child: AdaptiveTheme(
        light: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            light,
          ],
        ),
        dark: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            dark,
          ],
        ),
        initial: AdaptiveThemeMode.light,
        builder: (light, dark) => MaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: light,
          darkTheme: dark,
          builder: (context, widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget!),
            defaultScale: true,
            minWidth: 350,
            defaultName: DESKTOP,
            breakpoints: [
              const ResponsiveBreakpoint.resize(350, name: MOBILE),
              const ResponsiveBreakpoint.resize(590, name: 'BIGMOBILE'),
              const ResponsiveBreakpoint.resize(1366, name: TABLET),
              const ResponsiveBreakpoint.resize(1694, name: DESKTOP),
              const ResponsiveBreakpoint.resize(2022, name: '2K'),
              const ResponsiveBreakpoint.resize(2460, name: '4K'),
            ],
          ),
        ),
      ),
    );
  }
}

List<BlocProvider> listOfBlocs() {
  return [
    BlocProvider<GetSingleProfileBloc>(
      create: (ctx) => sl<GetSingleProfileBloc>(),
    ),
    BlocProvider<AuthBloc>(
      create: (ctx) => sl<AuthBloc>(),
    ),
    BlocProvider<ConnectingCodeBloc>(
      create: (ctx) => sl<ConnectingCodeBloc>(),
    ),
    BlocProvider<BiometricBloc>(
      create: (ctx) => sl<BiometricBloc>(),
    ),
    BlocProvider<FetchNewsBloc>(
      create: (ctx) => sl<FetchNewsBloc>(),
    ),
    BlocProvider<FetchQuestionsBloc>(
      create: (ctx) => sl<FetchQuestionsBloc>(),
    ),
    BlocProvider<NavigationBarBloc>(
      create: (ctx) => sl<NavigationBarBloc>(),
    ),
    BlocProvider<FilterContactsBloc>(
      create: (ctx) => sl<FilterContactsBloc>(),
    ),
    BlocProvider<ContactsBloc>(
      create: (ctx) => sl<ContactsBloc>(),
    ),
    BlocProvider<FilterDeclarationsBloc>(
      create: (ctx) => sl<FilterDeclarationsBloc>(),
    ),
    BlocProvider<DeclarationsBloc>(
      create: (ctx) => sl<DeclarationsBloc>(),
    ),
    BlocProvider<SingleDeclarationBloc>(
      create: (ctx) => sl<SingleDeclarationBloc>(),
    ),
    BlocProvider<ConnectingDevicesBloc>(
      create: (ctx) => sl<ConnectingDevicesBloc>(),
    ),
    BlocProvider<MainSearchBloc>(
      create: (ctx) => sl<MainSearchBloc>(),
    ),
    BlocProvider<GetSingleNewsBloc>(
      create: (ctx) => sl<GetSingleNewsBloc>(),
    ),
    BlocProvider<GetSingleQuestionBloc>(
      create: (ctx) => sl<GetSingleQuestionBloc>(),
    ),
    BlocProvider<FilterVisibilityBloc>(
      create: (ctx) => sl<FilterVisibilityBloc>(),
    ),
    BlocProvider<TasksBloc>(
      create: (ctx) => sl<TasksBloc>(),
    ),
    BlocProvider<FingerPrintSupportBloc>(
      create: (ctx) => sl<FingerPrintSupportBloc>(),
    ),
    BlocProvider<IsFingerPrintEnabledBloc>(
      create: (ctx) => sl<IsFingerPrintEnabledBloc>(),
    ),
    BlocProvider<TurnOffFingerPrintBloc>(
      create: (ctx) => sl<TurnOffFingerPrintBloc>(),
    ),
    BlocProvider<FetchNewEmployeeBloc>(
      create: (ctx) => sl<FetchNewEmployeeBloc>(),
    ),
  ];
}

void _hiveAdaptersInit() {
  sl<HiveInterface>()
    ..registerAdapter(UserModelAdapter())
    ..registerAdapter(ContactModelAdapter())
    ..registerAdapter(ProfileModelAdapter())
    ..registerAdapter(ContactInfoModelAdapter())
    ..registerAdapter(ArticleModelAdapter())
    ..registerAdapter(ParagraphModelAdapter())
    ..registerAdapter(NewsModelAdapter())
    ..registerAdapter(FilterModelAdapter())
    ..registerAdapter(FilterItemModelAdapter())
    ..registerAdapter(ContactsModelAdapter())
    ..registerAdapter(ResponseModelAdapter())
    ..registerAdapter(FilterResponseModelAdapter())
    ..registerAdapter(DeclarationCardModelAdapter())
    ..registerAdapter(ConnectingDeviceModelAdapter())
    ..registerAdapter(ConnectingDevicesModelAdapter())
    ..registerAdapter(DevicePlatformAdapter())
    ..registerAdapter(DeclarationInfoModelAdapter())
    ..registerAdapter(DeclarationStepModelAdapter())
    ..registerAdapter(DescriptionEnumAdapter())
    ..registerAdapter(NewEmployeeModelAdapter())
    ..registerAdapter(DeclarationDocumentModelAdapter())
    ..registerAdapter(TaskStatusEnumAdapter())
    ..registerAdapter(TaskCardModelAdapter())
    ..registerAdapter(TasksResponseModelAdapter());
}
