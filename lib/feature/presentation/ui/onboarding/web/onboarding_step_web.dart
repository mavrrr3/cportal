import 'package:flutter/material.dart';
import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/onboarding_pop_up.dart';

class OnBoardingStepWeb extends StatelessWidget {
  final AnimationController animationController;
  final PageController pageController;
  final List<OnboardingEntity> content;
  final int currentIndex;
  final Function() onNext;
  final Function() onBack;

  const OnBoardingStepWeb({
    Key? key,
    required this.animationController,
    required this.pageController,
    required this.content,
    required this.currentIndex,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: OnBoardingPopUp(
        isNextArrow: true,
        onNext: onNext,
        onBack: onBack,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 17,
            bottom: 32,
            left: 32,
            right: 32,
          ),
          child: OnBoardingContentWeb(
            animationController: animationController,
            pageController: pageController,
            content: content,
            currentIndex: currentIndex,
          ),
        ),
      ),
    );
  }
}
