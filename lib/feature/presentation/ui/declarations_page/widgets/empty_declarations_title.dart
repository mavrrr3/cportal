import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyDeclarationsTitle extends StatelessWidget {
  const EmptyDeclarationsTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 55,
      ),
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.youHadntDeclarations,
          textAlign: TextAlign.center,
          style: theme.textTheme.px22.copyWith(
            color: theme.text!.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
