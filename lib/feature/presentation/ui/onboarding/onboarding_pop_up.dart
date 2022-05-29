import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cportal_flutter/feature/presentation/ui/finger_print/widgets/button.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/start_onboarding.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/widgets/animated_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingPopUp extends StatefulWidget {
  final bool isBackArrow;
  final bool isNextArrow;
  final Function()? onBack;
  final Function()? onNext;
  final Widget child;

  const OnBoardingPopUp({
    Key? key,
    required this.child,
    this.isBackArrow = true,
    this.isNextArrow = false,
    this.onBack,
    this.onNext,
  }) : super(key: key);

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

class OnBoardingContentWeb extends StatefulWidget {
  final List<OnboardingEntity> content;
  final int currentIndex;
  final PageController pageController;
  final AnimationController animationController;
  final bool isButton;
  final Function? onTap;

  const OnBoardingContentWeb({
    Key? key,
    required this.content,
    required this.currentIndex,
    required this.pageController,
    required this.animationController,
    this.isButton = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<OnBoardingContentWeb> createState() => _OnBoardingContentWebState();
}

class _OnBoardingContentWebState extends State<OnBoardingContentWeb> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Виджет прогресса.
        Row(
          children: widget.content
              .asMap()
              .map((key, value) {
                return MapEntry(
                  key,
                  AnimatedBar(
                    animationController: widget.animationController,
                    position: key,
                    currentIndex: widget.currentIndex,
                    height: 4,
                  ),
                );
              })
              .values
              .toList(),
        ),
        SizedBox(
          width: 855,
          height: 541,
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: widget.pageController,
            itemCount: widget.content.length,
            itemBuilder: (context, i) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 39),
                Text(
                  widget.content[i].title,
                  style: theme.textTheme.headline2,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.content[i].description,
                  style: theme.textTheme.headline5,
                ),
                const SizedBox(height: 110),
                Align(
                  alignment: Alignment.center,
                  child: widget.content[i].isVector
                      ? SvgPicture.asset(
                          widget.content[i].image,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          widget.content[i].image,
                          width: 406,
                          fit: BoxFit.cover,
                        ),
                ),
                if (widget.isButton) const SizedBox(height: 32),
                if (widget.isButton)
                  Align(
                    alignment: Alignment.center,
                    child: Button.factory(
                      context,
                      ButtonEnum.blue,
                      AppLocalizations.of(context)!.go_over,
                      () {
                        widget.onTap;
                      },
                      const Size(
                        328,
                        48,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
