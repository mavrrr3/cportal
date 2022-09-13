import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/create_declaration/widgets/declaration_textfield.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_headline.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DeclarationAgreement extends StatelessWidget {
  final String description;
  const DeclarationAgreement({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return Column(
      children: [
        DeclarationHeadline(
          title: localizedStrings.agreementNeeds,
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.px12.copyWith(
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        const SizedBox(height: 24),
        DeclarationTextField(
          controller: TextEditingController(),
          title: localizedStrings.comment,
        ),
      ],
    );
  }
}
