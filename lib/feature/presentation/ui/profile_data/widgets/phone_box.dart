import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneBox extends StatelessWidget {
  final String phoneNumber;

  const PhoneBox({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light ? theme.black?.withOpacity(0.04) : theme.text?.withOpacity(0.08),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.yourPhoneNumber,
              style: theme.textTheme.px12.copyWith(
                color: theme.textLight,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            Text(
              _getPrettyPhoneNumber(phoneNumber),
              style: theme.textTheme.px16.copyWith(
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPrettyPhoneNumber(String phoneNumber) {
    final regExp = RegExp(r'(\d{1}).*(\d{3}).*(\d{3}).*(\d{2}).*(\d{2})');
    final match = regExp.firstMatch(phoneNumber);

    return '+${match?.groups([1, 2, 3, 4, 5]).join(' ')}';
  }
}
