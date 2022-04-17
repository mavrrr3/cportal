import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/app_bloc_observer.dart';
import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:cportal_flutter/feature/data/models/user_model.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_auth_bloc/biometric_auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/pages/news_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/svg_icon.dart';
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

void main() => runZonedGuarded<void>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await AppConfig.load();
        await di.init();
        // await Firebase.initializeApp();
        await Hive.initFlutter();
        _hiveAdaptersInit();

        await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp],
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: listOfBlocs(),
      child: AdaptiveTheme(
        light: lightTheme(context),
        dark: darkTheme(context),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => ScreenUtilInit(
          builder: (() => MaterialApp.router(
                routerDelegate: router.routerDelegate,
                routeInformationParser: router.routeInformationParser,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: theme,
                darkTheme: darkTheme,
              )),
          designSize: const Size(360, 640),
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
    BlocProvider<PinCodeBloc>(
      create: (ctx) => sl<PinCodeBloc>(),
    ),
    BlocProvider<BiometricBloc>(
      create: (ctx) => sl<BiometricBloc>(),
    ),
    BlocProvider<FetchNewsBloc>(
      create: (ctx) => sl<FetchNewsBloc>(),
    ),
  ];
}

int _selectedItemIndex = 0;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    List<Widget> listPages = <Widget>[
      const NewsPage(),
    ];

    return Scaffold(
      body: listPages[_selectedItemIndex],
      bottomNavigationBar: Container(
        color: AppColors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavBarItem(
              index: 0,
              width: width,
              iconWidget: SvgIcon(null, path: 'navbar/main.svg', width: 24.0.w),
              text: 'Главная',
            ),
            NavBarItem(
              index: 1,
              width: width,
              iconWidget: SvgIcon(null, path: 'navbar/news.svg', width: 20.0.w),
              text: 'Новости',
            ),
            NavBarItem(
              index: 2,
              width: width,
              iconWidget:
                  SvgIcon(null, path: 'navbar/questions.svg', width: 22.0.w),
              text: 'Вопросы',
            ),
            NavBarItem(
              index: 3,
              width: width,
              iconWidget:
                  SvgIcon(null, path: 'navbar/declaration.svg', width: 22.0.w),
              text: 'Заявки',
            ),
            NavBarItem(
              index: 4,
              width: width,
              iconWidget:
                  SvgIcon(null, path: 'navbar/contacts.svg', width: 20.0.w),
              text: 'Контакты',
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final int index;
  final Widget iconWidget;
  final double width;

  final String text;
  const NavBarItem({
    Key? key,
    required this.index,
    required this.width,
    required this.iconWidget,
    required this.text,
  }) : super(key: key);

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = widget.index;
        });
      },
      child: Container(
        height: 56.h,
        width: widget.width / 5,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5.h),
            widget.iconWidget,
            SizedBox(height: 5.h),
            Text(
              widget.text,
              style: kMainTextInter.copyWith(fontSize: 9.sp),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
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
}
