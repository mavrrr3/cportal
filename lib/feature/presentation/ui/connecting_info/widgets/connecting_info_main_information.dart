import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectingInfoMainInformation extends StatelessWidget {
  const ConnectingInfoMainInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizedStrings.howToGetConnectingCode,
          style: theme.textTheme.px22.copyWith(height: 1.27),
        ),
        const SizedBox(height: 8),
        Text(
          localizedStrings.howToGetCodeText,
          style: theme.textTheme.px14,
        ),
        const SizedBox(height: 16),
        Text(
          localizedStrings.address,
          style: theme.textTheme.px14.copyWith(
            color: theme.text?.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          localizedStrings.addressForCode,
          style: theme.textTheme.px14,
        ),
      ],
    );
  }
}
