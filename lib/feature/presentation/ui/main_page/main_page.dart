import 'dart:developer';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/faq_widget.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/horizontal_listview.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_horizontal_scroll.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_input.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/today_widget.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/profile_popup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);
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
          if (_isAnimation && theme.brightness == Brightness.light)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: theme.hoverColor.withOpacity(0.2),
            ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                      ? 16
                      : 13,
                ),
                child: ResponsiveConstraints(
                  constraint:
                      kIsWeb ? const BoxConstraints(maxWidth: 704) : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getHorizontalPadding(context),
                        child: Row(
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
                                onTap: (() {
                                  ResponsiveWrapper.of(context)
                                          .isLargerThan(TABLET)
                                      ? showProfile(context)
                                      : context.pushNamed(
                                          NavigationRouteNames.profile,
                                        );
                                }),
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
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: getHorizontalPadding(context),
                        child: HorizontalListViewMain(
                          color: _isAnimation
                              ? theme.brightness == Brightness.light
                                  ? theme.splashColor.withOpacity(0.3)
                                  : theme.splashColor
                              : theme.splashColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: getHorizontalPadding(context),
                        child: const TodayWidget(),
                      ),
                      const SizedBox(height: 24),
                      !kIsWeb
                          ? Padding(
                              padding: EdgeInsets.only(
                                left: getSingleHorizontalPadding(context),
                              ),
                              child: const NewsHorizontalScroll(),
                            )
                          : Padding(
                              padding: getHorizontalPadding(context),
                              child: Wrap(
                                spacing: 16,
                                runSpacing: 20,
                                children: List.generate(
                                  listViewMap.length,
                                  (i) => NewsCardItem(
                                    width: 312,
                                    height: 152,
                                    imgPath:
                                        listViewMap[i]['imgPath'] as String,
                                    title: listViewMap[i]['title'] as String,
                                    dateTime:
                                        listViewMap[i]['dateTime'] as String,
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: getHorizontalPadding(context),
                        child: const FaqWidget(),
                      ),
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

Future<void> showProfile(BuildContext context) {
  return showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final ThemeData theme = Theme.of(context);

      // final double width = MediaQuery.of(context).size.width;
      // var horizontalPading = width * 0.28;
      // log(horizontalPading.toString());

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              bottom: 10.h,
              left: 100.w,
              right: 100.w,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: theme.splashColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 32.0,
                  right: 32.0,
                  bottom: 32.0,
                  top: 32.0,
                ),
                child: ProfilePopUp(),
              ),
            ),
          );
        },
      );
    },
  );
}
