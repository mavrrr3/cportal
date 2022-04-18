import 'package:cportal_flutter/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkModeTable extends StatelessWidget {
  const WorkModeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    var workModeMap = [
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

    return Column(
      children: [
        ...workModeMap
            .map(
              (row) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    row['day']!,
                    style: kMainTextRoboto.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    row['time']!,
                    style: kMainTextRoboto.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ],
    );
  }
}
