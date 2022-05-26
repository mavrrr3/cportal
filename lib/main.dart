import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/app_bloc_observer.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/data/models/filter_model.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:cportal_flutter/feature/data/models/user_model.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_auth_bloc/biometric_auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/service_locator.dart' as di;
import 'package:cportal_flutter/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:responsive_framework/responsive_framework.dart';

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
      // await Firebase.initializeApp();
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
      BlocOverrides.runZoned(
        () => runApp(const MyApp()),
        blocObserver: AppBlocObserver.instance(),
        eventTransformer: bloc_concurrency.sequential<Object?>(),
      );
    },
    (error, stackTrace) {
      if (kDebugMode) {
        print('Caught Framework error');
        // В debug режиме выводим ошибки в консоль
        FlutterError.dumpErrorToConsole(
          FlutterErrorDetails(exception: error),
        );
      } else {
        Zone.current.handleUncaughtError(error, stackTrace);
      }
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: listOfBlocs(),
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (() => AdaptiveTheme(
              light: lightTheme(),
              dark: darkTheme(),
              initial: AdaptiveThemeMode.light,
              builder: (light, dark) => MaterialApp.router(
                routerDelegate: router.routerDelegate,
                routeInformationParser: router.routeInformationParser,
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
                    const ResponsiveBreakpoint.autoScale(600, name: MOBILE),
                    const ResponsiveBreakpoint.resize(1024, name: TABLET),
                    const ResponsiveBreakpoint.resize(1080, name: DESKTOP),
                    const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
                  ],
                ),
              ),
            )),
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
    BlocProvider<PinCodeBloc>(
      create: (ctx) => sl<PinCodeBloc>(),
    ),
    BlocProvider<BiometricBloc>(
      create: (ctx) => sl<BiometricBloc>(),
    ),
    BlocProvider<FetchNewsBloc>(
      create: (ctx) => sl<FetchNewsBloc>(),
    ),
    BlocProvider<NavBarBloc>(
      create: (ctx) => sl<NavBarBloc>(),
    ),
    BlocProvider<FilterBloc>(
      create: (ctx) => sl<FilterBloc>(),
    ),
  ];
}

void _hiveAdaptersInit() {
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(UserTypeModelAdapter());
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(PositionModelAdapter());
  Hive.registerAdapter(PhoneModelAdapter());
  Hive.registerAdapter(ArticleModelAdapter());
  Hive.registerAdapter(ArticleTypeModelAdapter());
  Hive.registerAdapter(NewsModelAdapter());
  Hive.registerAdapter(FilterModelAdapter());
  Hive.registerAdapter(FilterItemModelAdapter());
}
