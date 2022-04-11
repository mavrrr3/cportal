import 'package:cportal_flutter/main.dart';
import 'package:cportal_flutter/presentation/ui/pages/connecting_code_page.dart';
import 'package:cportal_flutter/presentation/ui/pages/pin_code_page.dart';
import 'package:cportal_flutter/presentation/ui/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRouteNames {
  static const splashScreen = 'splash_screen';
  static const mainPage = 'main_page';
  static const connectingCode = 'connecting_code';
  static const createPin = 'create_pin';
  static const repeatPin = 'repeat_pin';
  static const inputPin = 'input_pin';
  static const fingerPrintPage = 'finger_print_page';
}

final GoRouter router = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  initialLocation: '/create_pin',
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
        child: const MyHomePage(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.connectingCode,
      path: '/connecting_code',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const ConnectingCodePage(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.createPin,
      path: '/create_pin',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const PinCodePage(route: 'create'),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.repeatPin,
      path: '/repeat_pin',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const PinCodePage(route: 'repeat'),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.inputPin,
      path: '/input_pin',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const PinCodePage(route: 'input'),
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
