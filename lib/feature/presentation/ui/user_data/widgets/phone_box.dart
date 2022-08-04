import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneBox extends StatelessWidget {
  const PhoneBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
                                  final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;


    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: theme.text?.withOpacity(0.04),
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
              style: theme.textTheme.px12
                  .copyWith(color: theme.textLight),
            ),
            Text(
              '+7 923 456 78 91',
              style: theme.textTheme.px16,
            ),
          ],
        ),
      ),
    );
  }
}
