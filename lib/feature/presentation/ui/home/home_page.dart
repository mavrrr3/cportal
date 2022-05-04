import 'dart:async';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/main_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/news_page.dart';
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
  @override
  void initState() {
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
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveVisibility(
                visible: false,
                visibleWhen: const [
                  Condition<dynamic>.largerThan(name: TABLET),
                ],
                child: DesktopMenu(
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
