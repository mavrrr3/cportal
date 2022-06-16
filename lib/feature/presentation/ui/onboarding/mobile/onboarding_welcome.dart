import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/finger_print/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class OnBoardingWelcome extends StatelessWidget {
  const OnBoardingWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

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
                          AppLocalizations.of(context)!
                              .findImportantInformation,
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
                GoRouter.of(context).pushNamed(NavigationRouteNames.onboarding);
              },
              const Size(double.infinity, 48),
            ),
          ),
        ],
      ),
    );
  }
}
