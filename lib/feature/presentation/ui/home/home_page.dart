import 'dart:async';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/news_code_enum.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/contacts_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/declarations_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/custom_bottom_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/main_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/news_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/quastions_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/web/onboarding_learning_course_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/web/onboarding_step_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/web/onboarding_welcome_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

const List<OnboardingEntity> _onboardingContent = [
  OnboardingEntity(
    title: 'Как общаться с коллегами?',
    description: 'Сегодня Вас включат в группу сотрудников Новосталь-М в WhatsApp.',
    image: 'assets/img/onboarding/1.svg',
  ),
  OnboardingEntity(
    title: 'Обязательно для ознакомления!',
    description:
        'Сегодня Вам будет назначен курс «Обучение по информационной безопасности», который Вам будет необходимо пройти в течение 2-х\nнедель с даты приема.',
    image: 'assets/img/onboarding/2.svg',
  ),
  OnboardingEntity(
    title: 'Любите читать?',
    description: 'В ближайшее время Вы будете подключены к электронной библиотеке Компании.',
    image: 'assets/img/onboarding/3.svg',
  ),
  OnboardingEntity(
    title: 'Изучайте иностранные языки',
    description:
        'В нашей компании проходят курсы по английскому и испанскому языкам. Вы можете присоединиться  к коллегам, изучающих иностранные языки,  для этого Вам нужно обратиться к сотруднику HR. Обучение языкам проходит за счет компании.',
    image: 'assets/img/onboarding/4.svg',
  ),
  OnboardingEntity(
    title: 'Голодным не останетесь',
    description: 'Компания предоставляет сотрудникам бесплатные обеды.',
    image: 'assets/img/onboarding/5.svg',
  ),
  OnboardingEntity(
    title: 'Как получить ДМС?',
    description:
        'После прохождения испытательного срока Вам будет оформлен полис ДМС и направлен страховой компанией на почту.',
    image: 'assets/img/onboarding/6.png',
    isVector: false,
  ),
  OnboardingEntity(
    title: 'Всегда рады ответить на вопросы',
    description: 'Дирекция по управлению персоналом',
    image: 'assets/img/onboarding/7.svg',
  ),
];

class HomePage extends StatefulWidget {
  final Widget child;
  final int desktopMenuIndex;

  const HomePage({
    Key? key,
    required this.child,
    required this.desktopMenuIndex,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, WidgetsBindingObserver {
  Timer? timer;
  // Для онбординга.
  late bool _isOnboarding;
  late bool _isWelcome;
  late bool _isLearningCourse;
  late int _onBoardingIndex;
  late PageController _pageController;
  late AnimationController _animationController;
  late Duration _pageDuration;

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

    // Список страниц для навигации должен
    // строго соответствовать количеству элемнтов навбара
    final List<Widget> listPages = <Widget>[
      const MainPage(),
      NewsPage(pageType: NewsCodeEnum.news),
      QuastionsPage(),
      const DeclarationsPage(),
      const ContactsPage(),
    ];

    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.background,
          body: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveVisibility(
                    visible: false,
                    visibleWhen: const [
                      Condition<dynamic>.largerThan(name: MOBILE),
                    ],
                    // Меню Web.
                    child: DesktopMenu(
                      onboarding: () {
                        setState(
                          () {
                            _isWelcome = true;
                          },
                        );
                      },
                      currentIndex: widget.desktopMenuIndex,
                      onChange: (index) => changePage(context, index),
                    ),
                  ),

                  // Текущая страница.
                  Expanded(
                    child: kIsWeb ? widget.child : listPages[state.currentIndex],
                  ),
                ],
              ),

              // -- Онбординг для Web --
              // Затемнение заднего фона
              if (_isOnboarding || _isWelcome || _isLearningCourse)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
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
                        'assets/icons/onboarding_close.svg',
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
                OnBoardingStepWeb(
                  animationController: _animationController,
                  pageController: _pageController,
                  content: _onboardingContent,
                  currentIndex: _onBoardingIndex,
                  onNext: () {
                    setState(() {
                      if (_onBoardingIndex + 1 < _onboardingContent.length) {
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
                ),

              // Обучающий курс (Последний этап онбординга).
              if (_isLearningCourse)
                OnBoardingLearningCourseWeb(
                  animationController: _animationController,
                  pageController: _pageController,
                  onBack: () {
                    setState(() {
                      _isOnboarding = true;
                      _isLearningCourse = false;
                      _onBoardingIndex = _onboardingContent.length - 1;
                      _loadOnboardingPage();
                    });
                  },
                ),
            ],
          ),

          // Bottom Bar.
          bottomNavigationBar: ResponsiveVisibility(
            hiddenWhen: const [
              Condition<dynamic>.largerThan(name: MOBILE),
            ],
            child: CustomBottomBar(state: state),
          ),
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
