import 'dart:async';
import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/new_employee_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/new_employee_bloc/fetch_new_employee_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/contacts_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/declarations_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/main_page_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/burger_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/custom_bottom_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/main_page_web_tablet.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/news_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/questions_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/web/onboarding_step_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/web/onboarding_welcome_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  final int webMenuIndex;

  const HomePage({
    Key? key,
    required this.child,
    required this.webMenuIndex,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  Timer? timer;
  // Для онбординга.
  late bool _isOnboarding;
  late bool _isWelcome;
  late bool _isLearningCourse;
  late int _onBoardingIndex;
  late PageController _pageController;
  late AnimationController _animationController;
  late Duration _pageDuration;
  List<NewEmployeeEntity> _onboardingContent = [];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _onBoardingIndex = 0;
    _pageController = PageController(initialPage: _onBoardingIndex);
    _animationController = AnimationController(vsync: this);
    _isWelcome = false;
    _isOnboarding = false;
    _isLearningCourse = false;

    _onboardingAnimationListener();
    _pageDuration = const Duration(seconds: 5);

    super.initState();
  }

  //
  // В случае сворачивания приложения отсчитывает delay
  // и перенаправляет на Ввод ПИН-кода
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused && !kIsWeb) {
      // TODO выставить нужный delay.
      // timer = Timer(
      //   const Duration(seconds: 10000000000000),
      //   _loadPinRequest,
      // );
    } else if (state == AppLifecycleState.resumed) {
      timer?.cancel();
    }
  }

  // Future<void> _loadPinRequest() async {
  //   if (mounted) context.goNamed(NavigationRouteNames.inputPin);
  // }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final size = MediaQuery.of(context).size;

    // Список страниц для навигации должен
    // строго соответствовать количеству элемнтов навбара
    final List<Widget> listPages = <Widget>[
      if (isMobile(context))
        const MainPageMobile()
      else
        const MainPageWebTablet(),
      const NewsPage(),
      const QuestionsPage(),
      const DeclarationsPage(),
      const ContactsPage(),
    ];

    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: theme.background,
              body: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isLargerThenTablet(context))
                        DesktopMenu(
                          onboarding: () {
                            setState(
                              () {
                                _isWelcome = true;
                              },
                            );
                          },
                          currentIndex: widget.webMenuIndex,
                          onChange: (index) =>
                              MenuService.changePage(context, index),
                        ),

                      // Текущая страница.
                      Expanded(
                        child: kIsWeb
                            ? widget.child
                            : listPages[state.currentIndex],
                      ),
                    ],
                  ),

                  // -- Онбординг для Web --
                  // Затемнение заднего фона
                  if (_isOnboarding || _isWelcome || _isLearningCourse)
                    Container(
                      width: size.width,
                      height: size.height,
                      color: theme.barrierColor,
                    ),

                  // Закрыть онбординг.
                  if (_isOnboarding || _isWelcome || _isLearningCourse)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 60,
                          top: 60,
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              _onBoardingIndex = 0;
                              _isWelcome = false;
                              _isOnboarding = false;
                              _isLearningCourse = false;
                              _animationController
                                ..stop()
                                ..reset();
                            });
                          },
                          child: SvgPicture.asset(
                            ImageAssets.onboardingClose,
                          ),
                        ),
                      ),
                    ),

                  // Добро пожаловать.
                  if (_isWelcome)
                    OnBoardingWelcomeWeb(
                      onTap: () {
                        setState(() {
                          _isWelcome = false;
                          _isOnboarding = true;
                        });
                        _loadOnboardingPage(animateToPage: false);
                      },
                    ),

                  // Контент онбординга и его навигация.
                  if (_isOnboarding)
                    BlocBuilder<FetchNewEmployeeBloc, FetchNewEmployeeState>(
                        builder: (context, state) {
                      if (state is NewEmployeeLoaded) {
                        _onboardingContent = state.slides;
                      }

                      return OnBoardingStepWeb(
                        animationController: _animationController,
                        pageController: _pageController,
                        content: _onboardingContent,
                        currentIndex: _onBoardingIndex,
                        onNext: () {
                          setState(() {
                            if (_onBoardingIndex + 1 <
                                _onboardingContent.length) {
                              _onBoardingIndex += 1;
                              _loadOnboardingPage();
                            } else {
                              setState(() {
                                _isOnboarding = false;
                                _isLearningCourse = true;
                                _animationController
                                  ..stop()
                                  ..reset()
                                  ..duration = const Duration(seconds: 5)
                                  ..forward();
                              });
                            }
                          });
                        },
                        onBack: () {
                          setState(() {
                            if (_onBoardingIndex - 1 >= 0) {
                              _onBoardingIndex -= 1;
                              _loadOnboardingPage();
                            }
                          });
                        },
                      );
                    }),
                ],
              ),

              // Bottom Bar.
              bottomNavigationBar: isMobile(context) || size.width < 514
                  ? const CustomBottomBar()
                  : null,
            ),
            BurgerMenu(
              currentIndex: widget.webMenuIndex,
              onChange: (i) => MenuService.changePage(context, i),
            ),
          ],
        );
      },
    );
  }

  // Отслеживает смену слайда онбординга Web и переключает на следующие этапы.
  void _onboardingAnimationListener() {
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController
          ..stop()
          ..reset();
        setState(() {
          if (_onBoardingIndex + 1 < _onboardingContent.length) {
            _onBoardingIndex += 1;
            _loadOnboardingPage();
          } else {
            if (_isLearningCourse) {
              setState(() {
                _isLearningCourse = false;
              });
            } else {
              setState(() {
                _isOnboarding = false;
                _isLearningCourse = true;
                _animationController
                  ..stop()
                  ..reset()
                  ..duration = const Duration(seconds: 5)
                  ..forward();
              });
            }
          }
        });
      }
    });
  }

  // Синхранизирует анимацию под нужный слайд онбординга.
  void _loadOnboardingPage({
    bool animateToPage = true,
  }) {
    _animationController
      ..stop()
      ..reset()
      ..duration = _pageDuration
      ..forward();

    if (animateToPage) {
      _pageController.jumpToPage(_onBoardingIndex);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
