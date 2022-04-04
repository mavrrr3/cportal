import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/data/models/hive_adapters/profile_hive_adapter.dart';
import 'package:cportal_flutter/data/models/hive_adapters/user_hive_adapter.dart';
import 'package:cportal_flutter/service_locator.dart' as di;
import 'package:cportal_flutter/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'presentation/ui/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  // await Firebase.initializeApp();
  await Hive.initFlutter();
  _hiveAdaptersInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetSingleProfileBloc>(
          create: (ctx) => sl<GetSingleProfileBloc>(),
        ),
      ],
      child: AdaptiveTheme(
        light: lightTheme(context),
        dark: darkTheme(context),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: theme,
          darkTheme: darkTheme,
          home: const MyHomePage(),
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
        title: Text(localization!.appTitle),
      ),
      body: const MainPage(),
    );
  }
}

void _hiveAdaptersInit() {
  Hive.registerAdapter(UserHiveAdapter());
  Hive.registerAdapter(ProfileHiveAdapter());
  Hive.registerAdapter(PositionHiveAdapter());
  Hive.registerAdapter(PhoneHiveAdapter());
}
