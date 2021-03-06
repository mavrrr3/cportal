import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/onboarding_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class OnBoardingWelcome extends StatelessWidget {
  const OnBoardingWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    // Контент страниц онбординга.
    final List<OnboardingEntity> onboardingContent = [
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title1,
        description: AppLocalizations.of(context)!.onboarding_description1,
        image: 'assets/img/onboarding/1.svg',
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title2,
        description: AppLocalizations.of(context)!.onboarding_description2,
        image: 'assets/img/onboarding/2.svg',
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title3,
        description: AppLocalizations.of(context)!.onboarding_description3,
        image: 'assets/img/onboarding/3.svg',
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title4,
        description: AppLocalizations.of(context)!.onboarding_description4,
        image: 'assets/img/onboarding/4.svg',
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title5,
        description: AppLocalizations.of(context)!.onboarding_description5,
        image: 'assets/img/onboarding/5.svg',
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title6,
        description: AppLocalizations.of(context)!.onboarding_description6,
        image: 'assets/img/onboarding/6.png',
        isVector: false,
      ),
      OnboardingEntity(
        title: AppLocalizations.of(context)!.onboarding_title7,
        description: AppLocalizations.of(context)!.onboarding_description7,
        image: 'assets/img/onboarding/7.svg',
      ),
    ];

    return Scaffold(
      backgroundColor: theme.cardColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                const SizedBox(height: 87),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcome,
                          style: theme.textTheme.header,
                        ),
                        Text(
                          AppLocalizations.of(context)!.findImportantInformation,
                          style: theme.textTheme.px16,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Button.factory(
              context,
              ButtonEnum.blue,
              AppLocalizations.of(context)!.forward,
              () {
                GoRouter.of(context).pushNamed(
                  NavigationRouteNames.onboarding,
                  extra: onboardingContent,
                );
              },
              const Size(double.infinity, 48),
            ),
          ),
        ],
      ),
    );
  }
}
