import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/mobile/onboarding_step_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/widgets/animated_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onboarding extends StatefulWidget {
  final List<OnboardingEntity> content;

  const Onboarding({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late PageController _pageController;
  late AnimationController _animationController;
  late List<OnboardingEntity> _onboardingContent;
  late Duration _pageDuration;

  @override
  void initState() {
    _currentIndex = 0;
    _pageController = PageController(initialPage: _currentIndex);
    _animationController = AnimationController(vsync: this);
    _onboardingContent = widget.content;

    // Время показа текущей страницы.
    _pageDuration = const Duration(seconds: 5);

    _loadPage(animateToPage: false);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController
          ..stop()
          ..reset();
        setState(() {
          if (_currentIndex + 1 < _onboardingContent.length) {
            _currentIndex += 1;
            _loadPage();
          } else {
            GoRouter.of(context).goNamed(NavigationRouteNames.onboardingEnd);
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      backgroundColor: theme.cardColor,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (details) => _onTapDown(details, _onboardingContent),
        onLongPressEnd: (details) {
          if (!_animationController.isAnimating) {
            _animationController.forward();
          }
        },
        onTapUp: (details) {
          if (!_animationController.isAnimating) {
            _animationController.forward();
          }
        },
        child:
            // Контент.
            SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 17),
              // Виджет прогресса.
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: _onboardingContent
                        .asMap()
                        .map((key, value) {
                          return MapEntry(
                            key,
                            AnimatedBar(
                              animationController: _animationController,
                              position: key,
                              currentIndex: _currentIndex,
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                ),
              ),

              // Страница онбординга.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: width,
                  height: height * 0.85,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: _onboardingContent.length,
                    itemBuilder: (context, i) =>
                        OnBoardingStepPage(content: _onboardingContent[i]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapDown(
    TapDownDetails details,
    List<OnboardingEntity> pages,
  ) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadPage();
        }
      });
    } else if (dx > screenWidth * 2 / 3) {
      setState(() {
        // ignore: prefer-conditional-expressions
        if (_currentIndex + 1 < pages.length) {
          _currentIndex += 1;
          _loadPage();
        } else {
          GoRouter.of(context).goNamed(NavigationRouteNames.onboardingEnd);
        }
      });
    } else {
      if (_animationController.isAnimating) {
        _animationController.stop();
      }
    }
  }

  void _loadPage({
    bool animateToPage = true,
  }) {
    _animationController
      ..stop()
      ..reset()
      ..duration = _pageDuration
      ..forward();

    if (animateToPage) {
      _pageController.jumpToPage(_currentIndex);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
