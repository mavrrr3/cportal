import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cportal_flutter/common/app_bloc_observer.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/data/models/profile_model.dart';
import 'package:cportal_flutter/data/models/user_model.dart';
import 'package:cportal_flutter/presentation/navigation.dart';
import 'package:cportal_flutter/service_locator.dart' as di;
import 'package:cportal_flutter/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'presentation/bloc/auth_bloc/auth_bloc.dart';
import 'presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'presentation/ui/pages/main_page.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

void main() => runZonedGuarded<void>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await di.init();
        // await Firebase.initializeApp();
        await Hive.initFlutter();
        _hiveAdaptersInit();
        BlocOverrides.runZoned(
          () => runApp(const MyApp()),
          blocObserver: AppBlocObserver.instance(),
          eventTransformer: bloc_concurrency.sequential<Object?>(),
        );
      },
      (error, stackTrace) {
        if (kDebugMode) {
          print('Error main: $error');
        }
      },
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigatorKey = GlobalKey<NavigatorState>();
    var navigation = Navigation();

    return MultiBlocProvider(
      providers: [
        BlocProvider<GetSingleProfileBloc>(
          create: (ctx) => sl<GetSingleProfileBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (ctx) => sl<AuthBloc>(),
        ),
      ],
      child: AdaptiveTheme(
        light: lightTheme(context),
        dark: darkTheme(context),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => ScreenUtilInit(
          builder: (() => MaterialApp(
                navigatorKey: _navigatorKey,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: theme,
                darkTheme: darkTheme,
                routes: navigation.routes,
                initialRoute: NavigationRouteNames.mainPage,
                onGenerateRoute: navigation.onGenerateRoute,
              )),
          designSize: const Size(360, 640),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(localization!.appTitle),
      ),
      body: const MainPage(),
    );
  }
}

void _hiveAdaptersInit() {
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(PositionModelAdapter());
  Hive.registerAdapter(PhoneModelAdapter());
}
