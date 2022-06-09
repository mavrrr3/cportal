import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InProcessTitle extends StatelessWidget {
  final ThemeData theme;
  const InProcessTitle({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        AppLocalizations.of(context)!.inProcess,
        style: theme.textTheme.headline5!.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
