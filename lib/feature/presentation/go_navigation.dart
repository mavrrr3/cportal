import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connection_code_web/connecting_code_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connection_code_web/qr_scanner_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/qr_scanner.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts/contact_profile_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts/contacts_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/home_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connecting_code_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/finger_print/finger_print_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/main_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/news_article_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/question_article_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/news_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/onboarding.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/onboarding_learning_course.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/start_onboard.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/create_pin_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/edit_pin.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/input_pin.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/pin_code_web/create_pin_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/pin_code_web/input_pin_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/profile_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/splash_screen/splash_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/user_data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRouteNames {
  static const splashScreen = 'splash_screen';
  static const mainPage = 'main_page';
  static const connectingCode = 'connecting_code';
  static const connectingCodeWeb = 'connecting_code_web';
  static const createPin = 'create_pin';
  static const createPinWeb = 'create_pin_web';
  static const inputPin = 'input_pin';
  static const inputPinWeb = 'input_pin_web';
  static const editPin = 'edit_pin';
  static const fingerPrint = 'finger_print';
  static const faceId = 'face_id';
  static const news = 'news';
  static const questions = 'questions';
  static const newsArticlePage = 'news_article_page';
  static const questionArticlePage = 'question_article_page';
  static const profile = 'profile';
  static const userData = 'user_data';
  static const qrScanner = 'qr_scanner';
  static const qrScannerWeb = 'qr_scanner_web';
  static const onBoardingStart = 'onboarding_start';
  static const onboarding = 'onboarding';
  static const onboardingEnd = 'onboarding_end';
  static const contacts = 'contacts';
  static const contactProfile = 'contact_profile';
}

final GoRouter router = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  initialLocation: '/',
  // debugLogDiagnostics: true,
  routes: <GoRoute>[
    GoRoute(
      name: NavigationRouteNames.splashScreen,
      path: '/splash_screen',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: SplashScreen()),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.mainPage,
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const HomePage(
          child: MainPage(),
          desktopMenuIndex: 0,
        ),
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
      name: NavigationRouteNames.connectingCodeWeb,
      path: '/connecting_code_web',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: ConnectingCodeWeb()),
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
      name: NavigationRouteNames.createPinWeb,
      path: '/create_pin_web',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(
          body: CreatePinWeb(),
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
      name: NavigationRouteNames.inputPinWeb,
      path: '/input_pin_web',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(
          body: InputPinWeb(),
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.fingerPrint,
      path: '/finger_print',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(
          body: FingerPrintOrFaceIdPage(
            route: NavigationRouteNames.fingerPrint,
          ),
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.faceId,
      path: '/face_id',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(
          body: FingerPrintOrFaceIdPage(
            route: NavigationRouteNames.faceId,
          ),
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.news,
      path: '/news',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const HomePage(
          child: NewsPage(pageType: NewsCodeEnum.news),
          desktopMenuIndex: 1,
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.newsArticlePage,
      path: '/news/:fid',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: const NewsArticlePage(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.questions,
      path: '/questions',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const HomePage(
          child: NewsPage(pageType: NewsCodeEnum.quastion),
          desktopMenuIndex: 2,
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.questionArticlePage,
      path: '/questions/:fid',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CustomTransitionPage<void>(
        key: state.pageKey,
        child: const QuestionArticlePage(),
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
      name: NavigationRouteNames.onBoardingStart,
      path: '/onboarding_start',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const StartBoarding(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.qrScanner,
      path: '/qr_scanner',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const QrScanner(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.qrScannerWeb,
      path: '/qr_scanner_web',
      pageBuilder: (BuildContext context, GoRouterState state) => MaterialPage(
        key: state.pageKey,
        child: const QrScannerWeb(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.onboarding,
      path: '/onboarding',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: Onboarding(content: state.extra! as List<OnboardingEntity>),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.onboardingEnd,
      path: '/onboarding_end',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: const OnboardingLearningCourse(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.contacts,
      path: '/contacts',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: const ContactsPage(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.contactProfile,
      path: '/users/profile/:fid',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: ContactProfile(
          user: state.extra! as ProfileEntity,
        ),
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
