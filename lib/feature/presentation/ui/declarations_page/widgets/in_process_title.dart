import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InProcessTitle extends StatelessWidget {
  final double bottomPadding;
  const InProcessTitle({
    Key? key,
    required this.bottomPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Text(
        AppLocalizations.of(context)!.inProcess,
        style: isLargerThenTablet(context)
            ? theme.textTheme.px32
            : theme.textTheme.px16.copyWith(
                fontWeight: FontWeight.w700,
              ),
      ),
    );
  }
}
