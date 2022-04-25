import 'dart:async';
import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/main_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/news_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

int _selectedItemIndex = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
      // TODO выставить нужный delay test CI
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
    final Color _nonActiveColor = AppColors.kLightTextColor.withOpacity(0.48);
    const Color _activeColor = AppColors.blue;

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
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5.h),
              iconWidget,
              SizedBox(height: 5.h),
              Text(
                text,
                style: kMainTextInter.copyWith(
                  fontSize: 9.sp,
                  color: _iconColor(index),
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: _listPages[_selectedItemIndex],
      bottomNavigationBar: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navBarItem(
              index: 0,
              width: _width,
              iconWidget: SvgIcon(
                _iconColor(0),
                path: 'navbar/main.svg',
                width: 24.w,
              ),
              text: 'Главная',
            ),
            _navBarItem(
              index: 1,
              width: _width,
              iconWidget: SvgIcon(
                _iconColor(1),
                path: 'navbar/news.svg',
                width: 20.w,
              ),
              text: 'Новости',
            ),
            _navBarItem(
              index: 2,
              width: _width,
              iconWidget: SvgIcon(
                _iconColor(2),
                path: 'navbar/questions.svg',
                width: 22.w,
              ),
              text: 'Вопросы',
            ),
            _navBarItem(
              index: 3,
              width: _width,
              iconWidget: SvgIcon(
                _iconColor(3),
                path: 'navbar/declaration.svg',
                width: 22.0.w,
              ),
              text: 'Заявки',
            ),
            _navBarItem(
              index: 4,
              width: _width,
              iconWidget: SvgIcon(
                _iconColor(4),
                path: 'navbar/contacts.svg',
                width: 20.0.w,
              ),
              text: 'Контакты',
            ),
          ],
        ),
      ),
    );
  }
}
