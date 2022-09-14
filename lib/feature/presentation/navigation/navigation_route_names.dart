import 'package:cportal_flutter/core/service/auth_service.dart';
import 'package:cportal_flutter/feature/data/repositories/auth_repository.dart';
import 'package:cportal_flutter/feature/domain/entities/new_employee_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation/pages/change_pin_code_page.dart';
import 'package:cportal_flutter/feature/presentation/navigation/pages/connecting_qr_page.dart';
import 'package:cportal_flutter/feature/presentation/navigation/pages/create_pin_code_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/biometric/enroll_face_id_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/biometric/enroll_finger_print_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connecting_code_mobile/qr_scanner.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connecting_code_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_info/connecting_code_info_web_popup.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/contact_profile_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/contacts_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/declarations_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/create_declaration/create_declaration_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/declaration_info_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/devices/connecting_devices_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/home_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/login/login_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/main_page_web_tablet.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/news_article_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/news_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile_data/profile_data_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/question/question_screen.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/questions_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/mobile/onboarding_learning_course.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/mobile/onboarding_welcome.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/onboarding.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/profile_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/splash_screen/splash_screen.dart';
import 'package:cportal_flutter/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRouteNames {
  static const splashScreen = 'splash_screen';
  static const mainPage = 'main';
  static const connectingCode = 'connecting_code';
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
  static const question = 'question';
  static const profile = 'profile';
  static const profileData = 'profile_data';
  static const onBoardingStart = 'onboarding_start';
  static const onboarding = 'onboarding';
  static const onboardingEnd = 'onboarding_end';
  static const contacts = 'contacts';
  static const contactProfile = 'contact_profile';
  static const declarations = 'declarations';
  static const createDeclaration = 'create_declaration';
  static const declarationInfo = 'declaration_info';
  static const taskInfo = 'task_info';
  static const devices = 'devices';
}

final GoRouter router = GoRouter(
  urlPathStrategy: UrlPathStrategy.path,
  initialLocation: '/splash_screen',
  refreshListenable: sl<AuthService>(),
  redirect: (state) {
    final authService = sl<AuthService>();

    const connectingCodeLocation = '/connecting_code';
    const connectingQrLocation = '/connecting_qr';
    const qrScannerLocation = '/qr_scanner';
    const connectingInfoLocation = '/connecting_code/info';
    const connectingInfoMobileLocation = '/connecting_code/info_mobile';

    final isGoingToConnectingCode = state.subloc == connectingCodeLocation;
    final isGoingToConnectingQr = state.subloc == connectingQrLocation;
    final isGoingToQrScanner = state.subloc == qrScannerLocation;
    final isGoingToConnectingCodeInfo =
        state.subloc == connectingInfoLocation || state.subloc == connectingInfoMobileLocation;

    final isAuthenticated = authService.authStatus == AuthenticationStatus.authenticated;
    final isUnAuthenticated = authService.authStatus == AuthenticationStatus.unauthenticated;

    if ((isGoingToConnectingQr || isGoingToQrScanner || isGoingToConnectingCodeInfo || isGoingToConnectingCodeInfo) &&
        !isAuthenticated) {
      return null;
    }

    if (isUnAuthenticated && !isGoingToConnectingCode) {
      return connectingCodeLocation;
    }

    return null;
  },
  routes: <GoRoute>[
    GoRoute(
      name: NavigationRouteNames.splashScreen,
      path: '/splash_screen',
      pageBuilder: (context, state) => const MaterialPage(
        child: Scaffold(body: SplashScreen()),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.connectingCode,
      path: '/connecting_code',
      pageBuilder: (context, state) => const MaterialPage(
        child: ConnectingCodeScreen(),
      ),
      routes: [
        GoRoute(
          name: NavigationRouteNames.connectingCodeInfo,
          path: 'info',
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionDuration: Duration.zero,
            barrierColor: Colors.transparent,
            barrierDismissible: true,
            opaque: false,
            child: const ConnectingCodeInfoWebPopup(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
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
        child: QrScanner(onScannedData: state.extra as Function(String data)),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.connectingQr,
      path: '/connecting_qr',
      pageBuilder: (context, state) => const MaterialPage(
        child: ConnectingQrPage(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.createPin,
      path: '/create_pin',
      pageBuilder: (context, state) => const MaterialPage(
        child: CreatePinCodePage(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.changePin,
      path: '/change_pin',
      pageBuilder: (context, state) => const MaterialPage(
        child: ChangePinCodePage(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.login,
      path: '/login',
      pageBuilder: (context, state) => const MaterialPage(
        child: LoginScreen(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.mainPage,
      path: '/main',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const HomePage(
          child: MainPageWebTablet(),
          webMenuIndex: 0,
        ),
      ),
      routes: [
        GoRoute(
          name: NavigationRouteNames.onBoardingStart,
          path: 'onboarding_start',
          pageBuilder: (context, state) => const NoTransitionPage<void>(
            child: OnBoardingWelcome(),
          ),
        ),
      ],
    ),
    GoRoute(
      name: NavigationRouteNames.enrollFaceId,
      path: '/enroll_face_id',
      pageBuilder: (context, state) => const MaterialPage(
        child: EnrollFaceIdScreen(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.enrollFingerPrint,
      path: '/enroll_finger_print',
      pageBuilder: (context, state) => const MaterialPage(
        child: EnrollFingerPrintScreen(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.news,
      path: '/news',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const HomePage(
          child: NewsPage(),
          webMenuIndex: 1,
        ),
      ),
      routes: [
        GoRoute(
          name: NavigationRouteNames.newsArticlePage,
          path: ':fid',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: NewsArticlePage(id: state.params['fid']!),
          ),
        ),
      ],
    ),
    GoRoute(
      name: NavigationRouteNames.questions,
      path: '/questions',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const HomePage(
          child: QuestionsPage(),
          webMenuIndex: 2,
        ),
      ),
      routes: [
        GoRoute(
          name: NavigationRouteNames.question,
          path: ':fid',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: QuestionScreen(id: state.params['fid']!),
          ),
        ),
      ],
    ),
    GoRoute(
      name: NavigationRouteNames.profile,
      path: '/profile',
      pageBuilder: (context, state) => const NoTransitionPage<void>(
        child: ProfilePage(),
      ),
      routes: [
        GoRoute(
          name: NavigationRouteNames.devices,
          path: 'devices',
          pageBuilder: (context, state) => const MaterialPage(
            child: ConnectingDevicesScreen(),
          ),
          redirect: (state) => kIsWeb ? '/main' : null,
        ),
        GoRoute(
          name: NavigationRouteNames.profileData,
          path: 'data/:fid',
          pageBuilder: (context, state) => MaterialPage(
            child: ProfileDataScreen(id: state.params['fid']!),
          ),
        ),
      ],
    ),
    GoRoute(
      name: NavigationRouteNames.onboarding,
      path: '/onboarding',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        child: Onboarding(content: state.extra! as List<NewEmployeeEntity>),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.onboardingEnd,
      path: '/onboarding_end',
      pageBuilder: (context, state) => const NoTransitionPage<void>(
        child: OnBoardingLearningCourse(),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.contacts,
      path: '/contacts',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const HomePage(
          child: ContactsPage(),
          webMenuIndex: 4,
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.declarations,
      path: '/declarations',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const HomePage(
          child: DeclarationsPage(),
          webMenuIndex: 3,
        ),
      ),
      routes: [
        GoRoute(
          name: NavigationRouteNames.createDeclaration,
          path: 'create',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const CreateDeclarationPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            ),
          ),
        ),
        GoRoute(
          name: NavigationRouteNames.declarationInfo,
          path: 'info/:fid',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: DeclarationInfoPage(
              id: state.params['fid']!,
              isTask: false,
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
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
      name: NavigationRouteNames.contactProfile,
      path: '/users/profile/:fid',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        child: ContactProfilePage(
          id: state.params['fid']!,
        ),
      ),
    ),
    GoRoute(
      name: NavigationRouteNames.taskInfo,
      path: '/tasks/info/:fid',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: DeclarationInfoPage(
          id: state.params['fid']!,
          isTask: true,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        ),
      ),
    ),
  ],
  errorPageBuilder: (context, state) => NoTransitionPage<void>(
    child: Center(
      child: Text(state.error.toString()),
    ),
  ),
);
