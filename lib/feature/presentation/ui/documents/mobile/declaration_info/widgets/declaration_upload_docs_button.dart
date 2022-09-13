import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeclarationUploadDocsButton extends StatefulWidget {
  final bool isActive;
  final Function() onTap;

  const DeclarationUploadDocsButton({
    super.key,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<DeclarationUploadDocsButton> createState() =>
      _DeclarationUploadDocsButtonState();
}

class _DeclarationUploadDocsButtonState
    extends State<DeclarationUploadDocsButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return Column(
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: widget.isActive ? 0 : 1,
          child: Text(
            localizedStrings.documentsRequired,
            style: theme.textTheme.px14Bold.copyWith(
              leadingDistribution: TextLeadingDistribution.even,
              color: theme.documentRed,
            ),
          ),
        ),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.isActive
                ? theme.primary
                : theme.brightness == Brightness.light
                    ? const Color(0xff85A7E1)
                    : theme.primary?.withOpacity(0.68),
          ),
          child: Button.factory(
            context,
            type: ButtonEnum.text,
            text: localizedStrings.done,
            onTap: () {
              if (widget.isActive) {
                widget.onTap();
              }
            },
            color:
                widget.isActive ? theme.white : theme.white?.withOpacity(0.68),
          ),
        ),
      ],
    );
  }
}
