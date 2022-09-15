import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/create_declaration/widgets/declaration_textfield.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_headline.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DeclarationAgreement extends StatelessWidget {
  final String description;
  final Function() onAgreed;

  const DeclarationAgreement({
    super.key,
    required this.description,
    required this.onAgreed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DeclarationHeadline(
          title: localizedStrings.agreementNeeds,
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.px12.copyWith(
            color: theme.textLight,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        const SizedBox(height: 24),
        DeclarationTextField(
          controller: TextEditingController(),
          title: localizedStrings.comment,
        ),
        const SizedBox(height: 32),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button.factory(
              context,
              type: ButtonEnum.filled,
              text: localizedStrings.notAgreed,
              onTap: () {},
              color: theme.red,
            ),
            const SizedBox(height: 8),
            Button.factory(
              context,
              type: ButtonEnum.filled,
              text: localizedStrings.agreed,
              onTap: onAgreed,
            ),
          ],
        ),
      ],
    );
  }
}
