import 'package:cportal_flutter/feature/presentation/ui/home/home_page.dart';
import 'package:cportal_flutter/main.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connecting_code_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/finger_print/finger_print_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/news_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/pin_code_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRouteNames {
  static const splashScreen = 'splash_screen';
  static const mainPage = 'main_page';
  static const connectingCode = 'connecting_code';
  static const createPin = 'create_pin';
  static const repeatPin = 'repeat_pin';
  static const inputPin = 'input_pin';
  static const fingerPrintPage = 'fingerprint';
  static const news = 'news';
}

final GoRouter router = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  initialLocation: '/main_page',
  // debugLogDiagnostics: true,
  routes: <GoRoute>[
    GoRoute(
      name: NavigationRouteNames.splashScreen,
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: SplashScreen()),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.mainPage,
      path: '/main_page',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const HomePage(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.connectingCode,
      path: '/connecting_code',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: ConnectingCodePage()),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.createPin,
      path: '/create_pin',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: PinCodePage()),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.repeatPin,
      path: '/repeat_pin',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: PinCodePage()),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.inputPin,
      path: '/input_pin',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: PinCodePage()),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.fingerPrintPage,
      path: '/fingerprint',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: FingerPrintPage()),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.news,
      path: '/news',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: NewsPage()),
      ),
    ),
  ],
  errorPageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
    key: state.pageKey,
    child: Center(
      child: Text(state.error.toString()),
    ),
  ),
);
