import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkModeTable extends StatelessWidget {
  const WorkModeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final locale = AppLocalizations.of(context)!;
    final textStyle = theme.textTheme.px14.copyWith(height: 1.43);

    return Column(
      children: _getWorkMode(locale)
          .map(
            (row) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  row['day']!,
                  style: textStyle,
                ),
                Text(
                  row['time']!,
                  style: textStyle,
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  List<Map<String, String>> _getWorkMode(AppLocalizations locale) => [
        {
          'day': locale.monday,
          'time': locale.workTime,
        },
        {
          'day': locale.tuesday,
          'time': locale.workTime,
        },
        {
          'day': locale.wednesday,
          'time': locale.workTime,
        },
        {
          'day': locale.thursday,
          'time': locale.workTime,
        },
        {
          'day': locale.friday,
          'time': locale.workTime,
        },
        {
          'day': locale.saturday,
          'time': locale.weekEnd,
        },
        {
          'day': locale.sunday,
          'time': locale.weekEnd,
        },
      ];
}
