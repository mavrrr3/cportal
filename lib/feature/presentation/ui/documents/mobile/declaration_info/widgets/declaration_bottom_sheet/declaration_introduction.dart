import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_headline.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DeclarationIntroduction extends StatelessWidget {
  final Function() onTapResults;
  final Function() onDone;

  const DeclarationIntroduction({
    super.key,
    required this.onTapResults,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DeclarationHeadline(
          title: localizedStrings.introductionNeeds,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              localizedStrings.checkAgreementResult1,
              style: theme.textTheme.px12.copyWith(
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTapResults,
              child: Text(
                localizedStrings.checkAgreementResult2,
                style: theme.textTheme.px12.copyWith(
                  color: theme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Button.factory(
          context,
          type: ButtonEnum.filled,
          text: localizedStrings.introduced,
          onTap: () {},
        ),
      ],
    );
  }
}
