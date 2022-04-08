import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/presentation/ui/widgets/button.dart';
import 'package:cportal_flutter/presentation/ui/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FingerPrintPage extends StatelessWidget {
  const FingerPrintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFE5E5E5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
              ),
              child: Column(
                children: [
                  SizedBox(height: 48.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgIcon(null, path: 'logo_grey.svg', width: 24.0.w),
                    ],
                  ),
                  SizedBox(height: 31.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.useFingerPrint,
                            style: kMainTextRusso.copyWith(
                              fontSize: 28.sp,
                              height: 1.286,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.doFingerPrintNotInputPin,
                        style: kMainTextRoboto.copyWith(
                          fontSize: 14.sp,
                          height: 1.714,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 48.h),
                  SvgIcon(
                    AppColors.kLightTextColor.withOpacity(0.1),
                    path: 'finger_print.svg',
                    width: 149.21.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.0.w,
                      right: 16.0.w,
                      top: 62.87.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Button.factory(
                          ButtonEnum.blue,
                          AppLocalizations.of(context)!.yes,
                          () {
                            _showUseScanFingerPrint(context);
                          },
                        ),
                        Button.factory(
                          ButtonEnum.outlined,
                          AppLocalizations.of(context)!.noThanks,
                          () {
                            debugPrint('');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showUseScanFingerPrint(BuildContext context) {
  return showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: true, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(16.0.w, 8.0.h, 16.0.w, 28.0.h),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.useScanerFingerPrint,
                    style: kMainTextRoboto.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SvgIcon(
                    AppColors.green,
                    path: 'finger_print.svg',
                    width: 37.3.w,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppLocalizations.of(context)!.authToContinue,
                    style: kMainTextRoboto.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.kLightTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Button.factory(
                ButtonEnum.text,
                AppLocalizations.of(context)!.cancel,
                () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    },
  );
}
