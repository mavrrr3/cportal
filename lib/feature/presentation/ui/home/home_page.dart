import 'dart:async';
import 'dart:developer';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/main_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/news_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

int _selectedItemIndex = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late List<MenuButtonModel> _menuItems;
  Timer? timer;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _menuItems = [
      MenuButtonModel(
        img: 'assets/icons/navbar/main.svg',
        text: 'Главная',
      ),
      MenuButtonModel(
        img: 'assets/icons/navbar/news.svg',
        text: 'Новости',
      ),
      MenuButtonModel(
        img: 'assets/icons/navbar/questions.svg',
        text: 'Вопросы',
      ),
      MenuButtonModel(
        img: 'assets/icons/navbar/declaration.svg',
        text: 'Заявки',
      ),
      MenuButtonModel(
        img: 'assets/icons/navbar/contacts.svg',
        text: 'Контакты',
      ),
    ];

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

    Color _iconColor(int index) {
      return _selectedItemIndex == index ? _activeColor : _nonActiveColor;
    }

    Color _textColor(int index) {
      final ThemeData theme = Theme.of(context);

      // ignore: prefer-conditional-expressions
      if (theme.brightness == Brightness.light) {
        return _selectedItemIndex == index ? _activeColor : _nonActiveColor;
      } else {
        return _selectedItemIndex == index ? _activeColor : Colors.white;
      }
    }

    GestureDetector _navBarItem({
      required int index,
      required double width,
      required Widget iconWidget,
      required String text,
    }) {
      return GestureDetector(
        onTap: () => setState(
          () => _selectedItemIndex = index,
        ),
        child: Container(
          height: 56.h,
          width: width / 5,
          decoration: BoxDecoration(
            color: theme.splashColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              iconWidget,
              const SizedBox(height: 5),
              Text(
                text,
                style: theme.textTheme.bodyText2!.copyWith(
                  color: _textColor(index),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveVisibility(
            visible: false,
            visibleWhen: const [Condition<dynamic>.largerThan(name: TABLET)],
            child: DesktopMenu(
              currentIndex: _selectedItemIndex,
              onChange: (index) {
                setState(() {
                  _selectedItemIndex = index;
                });
              },
              items: _menuItems,
            ),
          ),
          Expanded(child: _listPages[_selectedItemIndex]),
        ],
      ),
      bottomNavigationBar: SizedBox(
        child: ResponsiveVisibility(
          hiddenWhen: const [Condition<dynamic>.largerThan(name: TABLET)],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navBarItem(
                index: 0,
                width: _width,
                iconWidget: SvgIcon(
                  _iconColor(0),
                  path: 'navbar/main.svg',
                  width: 24,
                ),
                text: 'Главная',
              ),
              _navBarItem(
                index: 1,
                width: _width,
                iconWidget: SvgIcon(
                  _iconColor(1),
                  path: 'navbar/news.svg',
                  width: 20,
                ),
                text: 'Новости',
              ),
              _navBarItem(
                index: 2,
                width: _width,
                iconWidget: SvgIcon(
                  _iconColor(2),
                  path: 'navbar/questions.svg',
                  width: 22,
                ),
                text: 'Вопросы',
              ),
              _navBarItem(
                index: 3,
                width: _width,
                iconWidget: SvgIcon(
                  _iconColor(3),
                  path: 'navbar/declaration.svg',
                  width: 22,
                ),
                text: 'Заявки',
              ),
              _navBarItem(
                index: 4,
                width: _width,
                iconWidget: SvgIcon(
                  _iconColor(4),
                  path: 'navbar/contacts.svg',
                  width: 20.0,
                ),
                text: 'Контакты',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
