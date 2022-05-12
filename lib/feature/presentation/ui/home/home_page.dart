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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  Timer? timer;
  late bool _isOnboarding;
  @override
  void initState() {
    _isOnboarding = false;
    WidgetsBinding.instance?.addObserver(this);

    super.initState();
  }

  void _loadPinRequest() async {
    if (mounted) context.goNamed(NavigationRouteNames.inputPin);
  }

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
                            _isOnboarding = true;
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
              if (_isOnboarding)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: theme.hoverColor.withOpacity(0.2),
                ),

              // Закрыть онбординг
              if (_isOnboarding)
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
                          _isOnboarding = false;
                        });
                      },
                      child: SvgPicture.asset(
                        'assets/icons/onboarding_close.svg',
                      ),
                    ),
                  ),
                ),

              // Контент онбординга и его навигация
              if (_isOnboarding)
                Align(
                  alignment: Alignment.center,
                  child: OnBoardingPopUp(
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
                                AppLocalizations.of(context)!
                                    .findImportantInformation,
                                style: theme.textTheme.headline5,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 174.0, right: 206),
                            child: Button.factory(
                              context,
                              ButtonEnum.blue,
                              AppLocalizations.of(context)!.forward,
                              () {},
                              const Size(double.infinity, 48),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
}

class OnBoardingPopUp extends StatefulWidget {
  const OnBoardingPopUp({
    Key? key,
    required this.child,
    this.isBackArrow = false,
    this.isNextArrow = false,
    this.onBack,
    this.onNext,
  }) : super(key: key);

  final bool isBackArrow;
  final bool isNextArrow;
  final Function()? onBack;
  final Function()? onNext;
  final Widget child;

  @override
  State<OnBoardingPopUp> createState() => _OnBoardingPopUpState();
}

class _OnBoardingPopUpState extends State<OnBoardingPopUp> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.isBackArrow)
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: widget.onBack,
            child: SvgPicture.asset(
              'assets/icons/onboarding_arrow_back.svg',
            ),
          ),
        const SizedBox(width: 53),
        Container(
          width: 844,
          height: 601,
          decoration: BoxDecoration(
            color: theme.splashColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: widget.child,
        ),
        const SizedBox(width: 53),
        if (widget.isNextArrow)
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: widget.onNext,
            child: SvgPicture.asset(
              'assets/icons/onboarding_arrow_next.svg',
            ),
          ),
      ],
    );
  }
}
