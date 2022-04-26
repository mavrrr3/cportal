import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/home_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connecting_code_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/finger_print/finger_print_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/news_article_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/question_article_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/news_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/start_onboard.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/create_pin_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/edit_pin.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/input_pin.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/profile_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/splash_screen/splash_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/user_data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRouteNames {
  static const splashScreen = 'splash_screen';
  static const mainPage = 'main_page';
  static const connectingCode = 'connecting_code';
  static const createPin = 'create_pin';
  static const inputPin = 'input_pin';
  static const editPin = 'edit_pin';
  static const fingerPrintPage = 'fingerprint';
  static const news = 'news';
  static const newsArticlePage = 'news_article_page';
  static const questionArticlePage = 'question_article_page';
  static const profile = 'profile';
  static const userData = 'user_data';
  static const onBoarding = 'on_boarding';
}

final GoRouter router = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  initialLocation: '/on_boarding',
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
        child: const Scaffold(
          body: CreatePinPage(),
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.editPin,
      path: '/edit_pin',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(
          body: EditPinPage(),
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.inputPin,
      path: '/input_pin',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(
          body: InputPinPage(),
        ),
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
        child: const Scaffold(body: NewsPage(pageType: NewsCodeEnum.news)),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.newsArticlePage,
      path: '/news_article_page',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CustomTransitionPage<void>(
        key: state.pageKey,
        child: NewsArticlePage(currentIndex: state.extra! as int),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.questionArticlePage,
      path: '/question_article_page',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CustomTransitionPage<void>(
        key: state.pageKey,
        child: QuestionArticlePage(currentIndex: state.extra! as int),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.profile,
      path: '/profile',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: ProfilePage()),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.userData,
      path: '/user_data',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: UserData()),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.onBoarding,
      path: '/on_boarding',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: StartBoarding()),
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
