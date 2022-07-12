import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DeclarationDateAndPriority extends StatelessWidget {
  final DateTime date;
  final String priority;
  const DeclarationDateAndPriority({
    Key? key,
    required this.date,
    required this.priority,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    final dateFormatter = DateFormat('d.MM.yyyy\nH:m:s');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.dateAndTime,
              style: theme.textTheme.px14,
            ),
            const SizedBox(height: 8),
            Text(
              dateFormatter.format(date),
              style: theme.textTheme.px16.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(width: 45),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset(
              ImageAssets.highPriority,
              width: 24,
            ),
            const SizedBox(width: 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.priority,
                  style: theme.textTheme.px14,
                ),
                const SizedBox(height: 12),
                Text(
                  priority,
                  style: theme.textTheme.px16
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
