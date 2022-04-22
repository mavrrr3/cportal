import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalizations.of(context)!.appTheme,
            style: kMainTextRoboto.copyWith(
              fontSize: 12,
              color: AppColors.kLightTextColor.withOpacity(0.68),
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
              color: AppColors.kLightTextColor.withOpacity(0.08),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100.w, 36.h),
                  primary: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  debugPrint('');
                },
                child: Text(
                  AppLocalizations.of(context)!.lightTheme,
                  style: kMainTextRoboto.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(100.w, 36.h),
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  // TODO реализовать переключение темы
                },
                child: Text(
                  AppLocalizations.of(context)!.darkTheme,
                  style: kMainTextRoboto.copyWith(
                    fontSize: 12,
                    color: AppColors.kLightTextColor,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
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
                  style: kMainTextRoboto.copyWith(
                    fontSize: 12,
                    color: AppColors.kLightTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
