import 'package:cportal_flutter/presentation/ui/pages/connecting_code_page.dart';
import 'package:cportal_flutter/presentation/ui/pages/main_page.dart';
import 'package:cportal_flutter/presentation/ui/pages/pin_code_page.dart';
import 'package:cportal_flutter/presentation/ui/pages/splash_screen.dart';
import 'package:flutter/material.dart';

abstract class NavigationRouteNames {
  static const splashScreen = '/';
  static const mainPage = '/main_page';
  static const connectingCode = '/connecting_code';
  static const inputPin = '/input_pin';
}

class Navigation {
  final routes = <String, Widget Function(BuildContext)>{
    NavigationRouteNames.splashScreen: (_) => const SplashScreen(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    final routeName = settings.name;

    switch (routeName) {
      case NavigationRouteNames.mainPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/main_page'),
          builder: (_) => const MainPage(),
        );
      case NavigationRouteNames.connectingCode:
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/connecting_code'),
          builder: (_) => const ConnectingCodePage(),
        );
      case NavigationRouteNames.inputPin:
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/input_pin'),
          builder: (_) => const PinCodePage(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<Object> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Ошибка навигации!'),
        ),
        body: const Center(
          child: Text('Error route!!!11'),
        ),
      );
    });
  }
}
