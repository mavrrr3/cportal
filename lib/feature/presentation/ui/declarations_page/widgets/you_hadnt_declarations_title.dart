import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class YouHadntDeclarationsTitle extends StatelessWidget {
  const YouHadntDeclarationsTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 55,
      ),
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.youHadntDeclarations,
          textAlign: TextAlign.center,
          style: theme.textTheme.headline3!.copyWith(
            color: theme.cardColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
