import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/feature/presentation/ui/onboarding/onboarding_pop_up.dart';

class OnBoardingWelcomeWeb extends StatelessWidget {
  final Function onTap;

  const OnBoardingWelcomeWeb({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Align(
      alignment: Alignment.center,
      child: OnBoardingPopUp(
        isBackArrow: false,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
            bottom: 32,
            left: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcome,
                    style: theme.textTheme.header,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.findImportantInformation,
                    style: theme.textTheme.px16,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 174, right: 206),
                child: Button.factory(
                  context,
                  ButtonEnum.blue,
                  AppLocalizations.of(context)!.forward,
                  onTap,
                  const Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
