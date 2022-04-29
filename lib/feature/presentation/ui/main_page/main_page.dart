import 'dart:developer';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/faq/widgets/faq_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/faq_widget.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/horizontal_listview.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_horizontal_scroll.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_input.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/today_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
              padding: getPagePadding(context),
              child: SingleChildScrollView(
                physics: _isAnimation
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                child: ResponsiveConstraints(
                  constraint: ResponsiveWrapper.of(context).isLargerThan(TABLET)
                      ? const BoxConstraints(maxWidth: 640)
                      : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SearchInput(
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
                            opacity: !ResponsiveWrapper.of(context)
                                    .isLargerThan(TABLET)
                                ? _isAnimation
                                    ? 0
                                    : 1
                                : 1,
                            child: GestureDetector(
                              onTap: (() => context.pushNamed(
                                    NavigationRouteNames.profile,
                                  )),
                              child: AvatarBox(
                                isAnimation: !ResponsiveWrapper.of(context)
                                        .isLargerThan(TABLET)
                                    ? _isAnimation
                                    : false,
                                size: 40,
                                imgPath:
                                    'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      HorizontalListViewMain(
                        color: _isAnimation
                            ? theme.splashColor.withOpacity(0.3)
                            : theme.splashColor,
                      ),
                      const SizedBox(height: 24),
                      const TodayWidget(),
                      const SizedBox(height: 24),
                      const NewsHorizontalScroll(),
                      const SizedBox(height: 24),
                      const FaqWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ResponsiveConstraints(
            constraint: ResponsiveWrapper.of(context).isLargerThan(TABLET)
                ? const BoxConstraints(maxWidth: 640)
                : null,
            child: SearchBox(
              isAnimation: _isAnimation,
              animationDuration: _animationDuration,
            ),
          ),
        ],
      ),
    );
  }
}
