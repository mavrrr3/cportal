import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/biometric/enroll_face_id_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/biometric/enroll_finger_print_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connecting_code_mobile/connecting_code_info_mobile_popup.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connecting_code_mobile/qr_scanner.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connecting_code_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connection_code_web/connecting_code_info_web_popup.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connection_code_web/connecting_qr_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/contact_profile_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/contacts_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/declarations_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/create_declaration_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/declaration_info_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/home_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/login/login_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/main_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/news_article_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/change_pin_code_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/question_article_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/news_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/questions_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/mobile/onboarding_learning_course.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/mobile/onboarding_welcome.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/onboarding.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/create_pin_code_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/profile_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/splash_screen/splash_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/user_data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRouteNames {
  static const splashScreen = 'splash_screen';
  static const mainPage = 'main_page';
  static const connectingCode = 'connecting_code';
  static const connectingCodeInfoMobile = 'connecting_code_info_mobile';
  static const connectingCodeInfo = 'connecting_code_info';
  static const connectingQr = 'connecting_qr';
  static const qrScanner = 'qr_scanner';
  static const createPin = 'create_pin';
  static const login = 'login';
  static const changePin = 'change_pin';
  static const enrollFaceId = 'enroll_face_id';
  static const enrollFingerPrint = 'enroll_finger_print';
  static const news = 'news_mobile';
  static const newsWeb = 'news';
  static const questions = 'questions';
  static const newsArticlePage = 'news_article_page';
  static const questionArticlePage = 'question_article_page';
  static const profile = 'profile';
  static const userData = 'user_data';
  static const onBoardingStart = 'onboarding_start';
  static const onboarding = 'onboarding';
  static const onboardingEnd = 'onboarding_end';
  static const contacts = 'contacts';
  static const contactProfile = 'contact_profile';
  static const declarations = 'declarations';
  static const createDeclaration = 'create_declaration';
  static const declarationInfo = 'declaration_info';
}

final GoRouter router = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  initialLocation: '/splash_screen',
  routes: <GoRoute>[
    GoRoute(
      name: NavigationRouteNames.splashScreen,
      path: '/splash_screen',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const Scaffold(body: SplashScreen()),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.connectingCode,
      path: '/connecting_code',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ConnectingCodeScreen(),
      ),
      routes: [
        GoRoute(
          name: NavigationRouteNames.connectingCodeInfoMobile,
          path: 'info_mobile',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            barrierColor: Colors.black54,
            barrierDismissible: true,
            fullscreenDialog: true,
            opaque: false,
            child: const ConnectingCodeInfoMobilePopup(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            ),
          ),
        ),
        GoRoute(
          name: NavigationRouteNames.connectingCodeInfo,
          path: 'info',
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionDuration: Duration.zero,
            key: state.pageKey,
            barrierColor: Colors.transparent,
            barrierDismissible: true,
            opaque: false,
            child: const ConnectingCodeInfoWebPopup(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      name: NavigationRouteNames.qrScanner,
      path: '/qr_scanner',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const QrScanner(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.connectingQr,
      path: '/connecting_qr',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ConnectingQrScreen(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.createPin,
      path: '/create_pin',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const CreatePinCodeScreen(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.changePin,
      path: '/change_pin',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ChangePinCodeScreen(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.login,
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.mainPage,
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const HomePage(
          child: MainPage(),
          desktopMenuIndex: 0,
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.enrollFaceId,
      path: '/enroll_face_id',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const EnrollFaceIdScreen(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.enrollFingerPrint,
      path: '/enroll_finger_print',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const EnrollFingerPrintScreen(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.news,
      path: '/news',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const HomePage(
          child: NewsPage(),
          desktopMenuIndex: 1,
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.newsArticlePage,
      path: '/news/:fid',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: NewsArticlePage(id: state.params['fid']!),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.questions,
      path: '/questions',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const HomePage(
          child: QuestionsPage(),
          desktopMenuIndex: 2,
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.questionArticlePage,
      path: '/questions/:fid',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: QuestionArticlePage(id: state.params['fid']!),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.profile,
      path: '/profile',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const ProfilePage(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.userData,
      path: '/user_data',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const UserData(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.onBoardingStart,
      path: '/onboarding_start',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const OnBoardingWelcome(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.onboarding,
      path: '/onboarding',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Onboarding(content: state.extra! as List<OnboardingEntity>),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.onboardingEnd,
      path: '/onboarding_end',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const OnBoardingLearningCourse(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.contacts,
      path: '/contacts',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const ContactsPage(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.declarations,
      path: '/declarations',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const DeclarationsPage(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.contactProfile,
      path: '/users/profile/:fid',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: ContactProfilePage(
          id: state.params['fid']!,
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.createDeclaration,
      path: '/declarations/create:fid',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: CreateDeclarationPage(
          id: state.params['fid']!,
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.declarationInfo,
      path: '/declarations/info',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const DeclarationInfoPage(),
      ),
    ),
  ],
  errorPageBuilder: (context, state) => NoTransitionPage<void>(
    key: state.pageKey,
    child: Center(
      child: Text(state.error.toString()),
    ),
  ),
);
