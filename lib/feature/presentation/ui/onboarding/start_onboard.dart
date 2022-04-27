import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/finger_print/widgets/button.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class StartBoarding extends StatelessWidget {
  const StartBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // Контент страниц онбординга
    final List<OnboardingEntity> _onboardingContent = [
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title1,
        description: AppLocalizations.of(context)!.onboarding_description1,
        image: 'assets/img/onboarding/1.png',
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title2,
        description: AppLocalizations.of(context)!.onboarding_description2,
        image: 'assets/img/onboarding/2.png',
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title3,
        description: AppLocalizations.of(context)!.onboarding_description3,
        image: 'assets/img/onboarding/3.png',
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title4,
        description: AppLocalizations.of(context)!.onboarding_description4,
        image: 'assets/img/onboarding/4.png',
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title5,
        description: AppLocalizations.of(context)!.onboarding_description5,
        image: 'assets/img/onboarding/5.png',
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title6,
        description: AppLocalizations.of(context)!.onboarding_description6,
        image: 'assets/img/onboarding/6.png',
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title7,
        description: AppLocalizations.of(context)!.onboarding_description7,
        image: 'assets/img/onboarding/7.png',
      ),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0.w,
          ),
          child: Column(
            children: [
              SizedBox(height: 87.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: theme.textTheme.headline2,
                      ),
                      Text(
                        AppLocalizations.of(context)!.findImportantInformation,
                        style: theme.textTheme.headline5,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Button.factory(
            context,
            ButtonEnum.blue,
            AppLocalizations.of(context)!.forward,
            () {
              GoRouter.of(context).pushNamed(
                NavigationRouteNames.onboarding,
                extra: _onboardingContent,
              );
            },
            Size(double.infinity, 48.h),
          ),
        ),
      ],
    );
  }
}