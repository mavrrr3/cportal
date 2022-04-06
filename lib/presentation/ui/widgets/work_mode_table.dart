import 'package:cportal_flutter/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkModeTable extends StatelessWidget {
  const WorkModeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _daysOfWeek = [
      AppLocalizations.of(context)!.monday,
      AppLocalizations.of(context)!.tuesday,
      AppLocalizations.of(context)!.wednesday,
      AppLocalizations.of(context)!.thursday,
      AppLocalizations.of(context)!.friday,
      AppLocalizations.of(context)!.saturday,
      AppLocalizations.of(context)!.sunday,
    ];

    return Column(
      children: [
        ..._daysOfWeek
            .map(
              (day) => TextWorkModeTable(
                dayText: day,
                timeText: day == AppLocalizations.of(context)!.saturday ||
                        day == AppLocalizations.of(context)!.sunday
                    ? AppLocalizations.of(context)!.weekEnd
                    : AppLocalizations.of(context)!.workTime,
              ),
            )
            .toList(),
      ],
    );
  }
}

class TextWorkModeTable extends StatelessWidget {
  final String dayText;
  final String timeText;
  const TextWorkModeTable({
    Key? key,
    required this.dayText,
    required this.timeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          dayText,
          style: kMainTextRoboto.copyWith(
            fontSize: 14.sp,
          ),
        ),
        Text(
          timeText,
          style: kMainTextRoboto.copyWith(
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
