import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/feature/domain/entities/new_employee_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/onboarding_pop_up.dart';

class OnBoardingLearningCourseWeb extends StatelessWidget {
  final AnimationController animationController;
  final PageController pageController;
  final Function() onBack;

  const OnBoardingLearningCourseWeb({
    Key? key,
    required this.animationController,
    required this.pageController,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: OnBoardingPopUp(
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
            isButton: true,
            onTap: () {
              // TODO: Отработать переход на курс.
            },
            content: [
              NewEmployeeEntity(
                title: AppLocalizations.of(context)!.onboarding_title8,
                description:
                    AppLocalizations.of(context)!.onboarding_description8,
                image: 'assets/img/onboarding/8.svg',
              ),
            ],
            currentIndex: 0,
          ),
        ),
      ),
    );
  }
}
