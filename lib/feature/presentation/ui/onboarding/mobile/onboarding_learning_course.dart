import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/finger_print/widgets/button.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/mobile/onboarding_step_page.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/widgets/animated_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class OnBoardingLearningCourse extends StatefulWidget {
  const OnBoardingLearningCourse({Key? key}) : super(key: key);

  @override
  State<OnBoardingLearningCourse> createState() =>
      _OnBoardingLearningCourseState();
}

class _OnBoardingLearningCourseState extends State<OnBoardingLearningCourse>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _animationController.duration = const Duration(seconds: 10);

    _animationController.forward().then(
          (value) =>
              GoRouter.of(context).goNamed(NavigationRouteNames.mainPage),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
                                 final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;


    return Scaffold(
      backgroundColor: theme.cardColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      AnimatedBar(
                        animationController: _animationController,
                        position: 0,
                        currentIndex: 0,
                      ),
                    ],
                  ),
                  OnBoardingStepPage(
                    content: OnboardingEntity(
                      title: AppLocalizations.of(context)!.onboarding_title8,
                      description:
                          AppLocalizations.of(context)!.onboarding_description8,
                      image: 'assets/img/onboarding/8.svg',
                    ),
                  ),
                ],
              ),
            ),
            Button.factory(
              context,
              ButtonEnum.blue,
              AppLocalizations.of(context)!.go_over,
              () {
                // TODO: обработать навигацию на прохождение курса.
              },
              const Size(double.infinity, 48),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
