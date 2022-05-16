import 'dart:async';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/finger_print/widgets/button.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/main_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/news_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/onboarding_pop_up.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/start_onboard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

final List<OnboardingEntity> _onboardingContent = [
  OnboardingEntity(
    title: 'Как общаться с коллегами?',
    description:
        'Сегодня Вас включат в группу сотрудников Новосталь-М в WhatsApp.',
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
    description:
        'В ближайшее время Вы будете подключены к электронной библиотеке Компании.',
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
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  Timer? timer;
  // Для онбординга
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

    _pageController = PageController(initialPage: _onBoardingIndex);
    _animationController = AnimationController(vsync: this);

    // Время показа текущей страницы
    _pageDuration = const Duration(seconds: 5);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if (_onBoardingIndex + 1 < _onboardingContent.length) {
            _onBoardingIndex += 1;
            _loadPage();
          } else {
            if (_isLearningCourse) {
              setState(() {
                _isLearningCourse = false;
              });
            } else {
              setState(() {
                _isOnboarding = false;
                _isLearningCourse = true;
              });
            }
          }
        });
      }
    });

    super.initState();
  }

  void _loadPinRequest() async {
    if (mounted) context.goNamed(NavigationRouteNames.inputPin);
  }

  // В случае сворачивания приложения отсчитывает delay
  // и перенаправляет на Ввод ПИН-кода
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      // TODO выставить нужный delay
      timer = Timer(
        const Duration(seconds: 10000000000000),
        () => _loadPinRequest(),
      );
    } else if (state == AppLifecycleState.resumed) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color _nonActiveColor = theme.brightness == Brightness.light
        ? theme.hoverColor.withOpacity(0.48)
        : theme.cardColor.withOpacity(0.48);
    final Color _activeColor = theme.primaryColor;

    final double _width = MediaQuery.of(context).size.width;

    // Список страниц для навигации должен
    // строго соответствовать количеству элемнтов навбара
    List<Widget> _listPages = <Widget>[
      const MainPage(),
      const NewsPage(pageType: NewsCodeEnum.news),
      const NewsPage(pageType: NewsCodeEnum.quastion),
      const MainPage(),
      const MainPage(),
    ];

    Color _iconColor(int index, NavBarState state) {
      return state.currentIndex == index ? _activeColor : _nonActiveColor;
    }

    Color _textColor(int index, NavBarState state) {
      final ThemeData theme = Theme.of(context);

      // ignore: prefer-conditional-expressions
      if (theme.brightness == Brightness.light) {
        return state.currentIndex == index ? _activeColor : _nonActiveColor;
      } else {
        return state.currentIndex == index ? _activeColor : Colors.white;
      }
    }

    GestureDetector _navBarItem({
      required NavBarState state,
      required int index,
      required Widget iconWidget,
      required String text,
    }) {
      return GestureDetector(
        onTap: () => setState(
          () => BlocProvider.of<NavBarBloc>(context)
              .add(NavBarEventImpl(index: index)),
        ),
        child: Container(
          height: 56,
          width: _width / 5,
          decoration: BoxDecoration(
            color: theme.splashColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: iconWidget,
              ),
              Text(
                text,
                style: theme.textTheme.bodyText2!.copyWith(
                  color: _textColor(index, state),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveVisibility(
                    visible: false,
                    visibleWhen: const [
                      Condition<dynamic>.largerThan(name: TABLET),
                    ],
                    child: DesktopMenu(
                      onboarding: () {
                        setState(
                          () {
                            _isWelcome = true;
                          },
                        );
                      },
                      currentIndex: state.currentIndex,
                      onChange: (index) {
                        BlocProvider.of<NavBarBloc>(context)
                            .add(NavBarEventImpl(index: index));
                      },
                      items: state.menuItems,
                    ),
                  ),
                  Expanded(
                    child: _listPages[state.currentIndex],
                  ),
                ],
              ),
              // Онбординг для Web
              // Затемнение заднего фона
              if (_isOnboarding || _isWelcome || _isLearningCourse)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: theme.hoverColor.withOpacity(0.2),
                ),

              // Закрыть онбординг
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
                          _animationController.stop();
                          _animationController.reset();
                        });
                      },
                      child: SvgPicture.asset(
                        'assets/icons/onboarding_close.svg',
                      ),
                    ),
                  ),
                ),

              // Добро пожаловать
              if (_isWelcome) _welcome(context, theme),

              // Контент онбординга и его навигация
              if (_isOnboarding) _onBoarding(),

              // Обучающий курс (Последний этап онбординга)
              if (_isLearningCourse) _learningCourse(context),
            ],
          ),
          bottomNavigationBar: SizedBox(
            child: ResponsiveVisibility(
              hiddenWhen: const [Condition<dynamic>.largerThan(name: TABLET)],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navBarItem(
                    state: state,
                    index: 0,
                    iconWidget: SvgPicture.asset(
                      state.menuItems[0].img,
                      color: _iconColor(0, state),
                      width: 24,
                    ),
                    text: state.menuItems[0].text,
                  ),
                  _navBarItem(
                    state: state,
                    index: 1,
                    iconWidget: SvgPicture.asset(
                      state.menuItems[1].img,
                      color: _iconColor(1, state),
                      width: 20,
                    ),
                    text: state.menuItems[1].text,
                  ),
                  _navBarItem(
                    state: state,
                    index: 2,
                    iconWidget: SvgPicture.asset(
                      state.menuItems[2].img,
                      color: _iconColor(2, state),
                      width: 22,
                    ),
                    text: state.menuItems[2].text,
                  ),
                  _navBarItem(
                    state: state,
                    index: 3,
                    iconWidget: SvgPicture.asset(
                      state.menuItems[3].img,
                      color: _iconColor(3, state),
                      width: 22,
                    ),
                    text: state.menuItems[3].text,
                  ),
                  _navBarItem(
                    state: state,
                    index: 4,
                    iconWidget: SvgPicture.asset(
                      state.menuItems[4].img,
                      color: _iconColor(4, state),
                      width: 20.0,
                    ),
                    text: state.menuItems[4].text,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _welcome(BuildContext context, ThemeData theme) {
    return Align(
      alignment: Alignment.center,
      child: OnBoardingPopUp(
        isBackArrow: false,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60.0,
            bottom: 32,
            left: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcome,
                    style: theme.textTheme.headline2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.findImportantInformation,
                    style: theme.textTheme.headline5,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 174.0, right: 206),
                child: Button.factory(
                  context,
                  ButtonEnum.blue,
                  AppLocalizations.of(context)!.forward,
                  () {
                    setState(() {
                      _isWelcome = false;
                      _isOnboarding = true;
                    });
                    _loadPage(animateToPage: false);
                  },
                  const Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _onBoarding() {
    return Align(
      alignment: Alignment.center,
      child: OnBoardingPopUp(
        isNextArrow: true,
        onNext: () {
          setState(() {
            // ignore: prefer-conditional-expressions
            if (_onBoardingIndex + 1 < _onboardingContent.length) {
              _onBoardingIndex += 1;
              _loadPage();
            } else {
              setState(() {
                _isOnboarding = false;
                _isLearningCourse = true;
                _animationController.stop();
                _animationController.reset();
                _animationController.duration = const Duration(seconds: 5);
                _animationController.forward();
              });
            }
          });
        },
        onBack: () {
          setState(() {
            if (_onBoardingIndex - 1 >= 0) {
              _onBoardingIndex -= 1;
              _loadPage();
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 17.0,
            bottom: 32,
            left: 32,
            right: 32,
          ),
          child: OnBoardingContentWeb(
            animationController: _animationController,
            pageController: _pageController,
            content: _onboardingContent,
            currentIndex: _onBoardingIndex,
          ),
        ),
      ),
    );
  }

  Widget _learningCourse(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: OnBoardingPopUp(
        onBack: () {
          setState(() {
            _isOnboarding = true;
            _isLearningCourse = false;
            _onBoardingIndex = _onboardingContent.length - 1;
            _loadPage();
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 17.0,
            bottom: 32,
            left: 32,
            right: 32,
          ),
          child: OnBoardingContentWeb(
            animationController: _animationController,
            pageController: _pageController,
            isButton: true,
            onTap: () {
              // TODO: Отработать переход на курс
            },
            content: [
              OnboardingEntity(
                title: AppLocalizations.of(context)!.onboarding_title8,
                description:
                    AppLocalizations.of(context)!.onboarding_description8,
                image: 'assets/img/onboarding/8.svg',
              ),
            ],
            currentIndex: 0,
          ),
        ),
      ),
    );
  }

  void _loadPage({
    bool animateToPage = true,
  }) {
    _animationController.stop();
    _animationController.reset();
    _animationController.duration = _pageDuration;
    _animationController.forward();

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
