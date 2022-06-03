import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneBox extends StatelessWidget {
  const PhoneBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: theme.hoverColor.withOpacity(0.04),
        borderRadius:const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.yourPhoneNumber,
              style: theme.textTheme.bodyText1!
                  .copyWith(color: theme.hoverColor.withOpacity(0.68)),
            ),
            Text(
              '+7 923 456 78 91',
              style: theme.textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
