import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalizations.of(context)!.appTheme,
            style: theme.textTheme.bodyText1!.copyWith(
              color: theme.hoverColor.withOpacity(0.68),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          height: 36.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.hoverColor.withOpacity(0.08),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100.w, 36.h),
                  primary: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  debugPrint('');
                },
                child: Text(
                  AppLocalizations.of(context)!.lightTheme,
                  style: theme.textTheme.bodyText1!
                      .copyWith(color: theme.splashColor),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(100.w, 36.h),
                  primary: theme.hoverColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  // TODO реализовать переключение темы
                },
                child: Text(
                  AppLocalizations.of(context)!.darkTheme,
                  style: theme.textTheme.bodyText1!
                      .copyWith(color: theme.hoverColor),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: theme.hoverColor,
                  minimumSize: Size(100.w, 36.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  debugPrint('');
                },
                child: Text(
                  AppLocalizations.of(context)!.standartTheme,
                  style: theme.textTheme.bodyText1!
                      .copyWith(color: theme.hoverColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
