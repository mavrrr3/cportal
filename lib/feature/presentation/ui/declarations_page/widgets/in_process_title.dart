import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InProcessTitle extends StatelessWidget {
  final CustomTheme theme;
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
        style: theme.textTheme.px16.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
