import 'dart:developer';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/faq/widgets/faq_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/faq_widget.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/horizontal_listview.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_horizontal_scroll.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_box_main.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/today_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TextEditingController _searchController;
  late FocusNode _searchFocus;
  late Duration _animationDuration;
  late bool _isAnimation;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocus = FocusNode();
    _animationDuration = const Duration(milliseconds: 300);
    _isAnimation = false;
    _searchFocus.addListener(_onFocusChange);
  }

  /// Анимация при нажатии на поиск
  void _onFocusChange() {
    if (_searchFocus.hasFocus) {
      setState(() {
        _isAnimation = true;
      });
    } else {
      setState(() {
        _isAnimation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          if (_isAnimation)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: theme.hoverColor.withOpacity(0.2),
            ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: SingleChildScrollView(
                physics: _isAnimation
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 11.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SearchBoxMain(
                          controller: _searchController,
                          focusNode: _searchFocus,
                          animationDuration: _animationDuration,
                          isAnimation: _isAnimation,
                          onChanged: (text) {
                            log('[Search text] $text');
                          },
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 150),
                          opacity: _isAnimation ? 0 : 1,
                          child: GestureDetector(
                            onTap: (() => context
                                .pushNamed(NavigationRouteNames.profile)),
                            child: AvatarBox(
                              isAnimation: _isAnimation,
                              size: 40,
                              imgPath:
                                  'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    HorizontalListViewMain(
                      color: _isAnimation
                          ? theme.splashColor.withOpacity(0.3)
                          : theme.splashColor,
                    ),
                    SizedBox(height: 24.h),
                    const TodayWidget(),
                    SizedBox(height: 24.h),
                    const NewsHorizontalScroll(),
                    SizedBox(height: 24.h),
                    const FaqWidget(),
                  ],
                ),
              ),
            ),
          ),
          _searchBox(context, theme),
        ],
      ),
    );
  }

  Widget _searchBox(BuildContext context, ThemeData theme) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: AnimatedOpacity(
          duration: _animationDuration,
          opacity: _isAnimation ? 1 : 0,
          curve: Curves.easeIn,
          child: Padding(
            padding: EdgeInsets.only(top: 56.0.h),
            child: AnimatedContainer(
              duration: _animationDuration,
              curve: Curves.easeIn,
              width: MediaQuery.of(context).size.width,
              height: _isAnimation ? 216.h : 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.splashColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _SearchBoxItem(
                        () => null,
                        category: 'Вопросы',
                        text: 'Как запросить 2НДФЛ',
                      ),
                      _SearchBoxItem(
                        () => null,
                        category: 'Профиль',
                        text: 'Сменить ПИН',
                      ),
                      _SearchBoxItem(
                        () => null,
                        category: 'Вопросы',
                        text: 'Сменить ПИН',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBoxItem extends StatelessWidget {
  final String category;
  final String text;
  final Function()? onTap;

  const _SearchBoxItem(
    this.onTap, {
    Key? key,
    required this.category,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: theme.textTheme.bodyText1!
                  .copyWith(color: theme.hoverColor.withOpacity(0.68)),
            ),
            SizedBox(height: 4.h),
            FaqRow(text: text),
          ],
        ),
      ),
    );
  }
}
