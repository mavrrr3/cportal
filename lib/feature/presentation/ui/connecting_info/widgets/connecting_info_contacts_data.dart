import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_info/widgets/document.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_info/widgets/phone_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectingInfoContactsData extends StatelessWidget {
  const ConnectingInfoContactsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final strings = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.getWithYou,
          style: theme.textTheme.px14.copyWith(
            color: theme.text?.withOpacity(0.6),
            height: 1.43,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Document(
              text: strings.passport,
            ),
            const SizedBox(width: 8),
            Document(
              text: strings.pass,
              color: theme.primary,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          strings.callBeforeCame,
          style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: PhoneButton(),
        ),
        Text(
          '${strings.callAfter} 6 ${strings.hours}',
          style: theme.textTheme.px14.copyWith(color: theme.red?.withOpacity(0.6)),
        ),
      ],
    );
  }
}
