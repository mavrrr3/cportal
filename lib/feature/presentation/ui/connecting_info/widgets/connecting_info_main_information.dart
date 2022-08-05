import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectingInfoMainInformation extends StatelessWidget {
  const ConnectingInfoMainInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final strings = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.howToGetConnectingCode,
          style: theme.textTheme.px22.copyWith(height: 1.27),
        ),
        const SizedBox(height: 8),
        Text(
          strings.howToGetCodeText,
          style: theme.textTheme.px14.copyWith(height: 1.43),
        ),
        const SizedBox(height: 16),
        Text(
          strings.address,
          style: theme.textTheme.px14.copyWith(
            color: theme.text?.withOpacity(0.6),
            height: 1.43,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          strings.addressForCode,
          style: theme.textTheme.px14.copyWith(height: 1.43),
        ),
      ],
    );
  }
}
