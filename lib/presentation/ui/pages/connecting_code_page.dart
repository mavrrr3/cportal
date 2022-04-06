import 'dart:developer';

import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/presentation/ui/widgets/custom_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final controller = TextEditingController();
final textEdited = controller.text;
final focusNode = FocusNode();
bool _isRightCode = true;

const mockupHeight = 640;
const mockupWidth = 360;

class ConnectingCodePage extends StatelessWidget {
  const ConnectingCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // var scale = mockupWidth / width;

    return ScreenUtilInit(
      builder: (() => Scaffold(
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
                            svgIcon('logo_grey.svg', 24.0.w),
                            svgIcon('qr_code.svg', 24.0.w),
                          ],
                        ),
                        SizedBox(height: 31.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .inputConnectingCode,
                                  style: kMainTextRusso.copyWith(
                                    fontSize: 28.sp,
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
                            GestureDetector(
                              onTap: () => _showHowToGetCOnnectingCode(context),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .howToGetConnectingCode,
                                style: kMainTextRoboto.copyWith(
                                  color: const Color(0xFF355A99),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 27.h),
                        const CellCodeInput(),
                        SizedBox(height: 8.h),
                        if (!_isRightCode) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Opacity(
                              opacity: 0.6,
                              child: colorText(
                                AppLocalizations.of(context)!
                                    .wrongConnectingCode,
                                'red',
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .tryToRepeatAfter30sec,
                              style: kMainTextRoboto.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.kLightTextColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomKeyboard(
                        controller: controller,
                      ),
                      SizedBox(height: 52.h),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

Widget svgIcon(path, width) {
  return SvgPicture.asset(
    'assets/icons/$path',
    width: width,
  );
}

class CellCodeInput extends StatefulWidget {
  const CellCodeInput({Key? key}) : super(key: key);

  @override
  _CellCodeInputState createState() => _CellCodeInputState();
}

class _CellCodeInputState extends State<CellCodeInput> {
  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 44.w,
      height: 52.h,
      textStyle: _isRightCode
          ? kMainTextRoboto
          : kMainTextRoboto.copyWith(color: AppColors.red),
      decoration: BoxDecoration(
        color: _isRightCode ? Colors.white : AppColors.lightRed,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    // Курсор, оставил код на случай если дизайнеры решат его всё таки сделать
    //
    // final cursor = Align(
    //   alignment: Alignment.bottomCenter,
    //   child: Container(
    //     width: 21,
    //     height: 1,
    //     margin: const EdgeInsets.only(bottom: 12),
    //     decoration: BoxDecoration(
    //       color: const Color.fromRGBO(137, 146, 160, 1),
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //   ),
    // );

    return Pinput(
      useNativeKeyboard: false,
      length: 6,
      controller: controller,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      separator: SizedBox(width: 11.w),
      focusedPinTheme: PinTheme(
        width: 52.w,
        height: 62.h,
        decoration: BoxDecoration(
          color: _isRightCode ? Colors.white : AppColors.lightRed,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(40, 42, 45, 0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
      showCursor: false,
      // cursor: cursor,
    );
  }
}

Future<void> _showHowToGetCOnnectingCode(BuildContext context) {
  bool _isShow = false;

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
            title: Text(
              AppLocalizations.of(context)!.howToGetCodeTitle,
              style: kMainTextRoboto.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.howToGetCodeText,
                    style: kMainTextRoboto.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: colorText(
                      AppLocalizations.of(context)!.address,
                      'grey',
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.addressForCode,
                      style: kMainTextRoboto.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.kLightTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      colorText(
                        AppLocalizations.of(context)!.workMode,
                        'grey',
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isShow = !_isShow;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 26.sp,
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _isShow,
                    child: workModeTable(context),
                  ),
                  SizedBox(height: 10.w),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: colorText(
                      AppLocalizations.of(context)!.getWithYou,
                      'grey',
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      whatGetWithYou(
                        'assets/icons/red_icon.svg',
                        AppLocalizations.of(context)!.passport,
                      ),
                      whatGetWithYou(
                        'assets/icons/blue_icon.svg',
                        AppLocalizations.of(context)!.pass,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: colorText(
                      AppLocalizations.of(context)!.callBeforeCame,
                      'grey',
                    ),
                  ),
                  SizedBox(height: 8.h),
                  phoneButton(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: colorText(
                      '${AppLocalizations.of(context)!.callAfter} 6 ${AppLocalizations.of(context)!.hours}',
                      'red',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding:
                    EdgeInsets.only(left: 8.0.w, right: 8.0.w, bottom: 8.0.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48.h),
                    primary: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context)!.close,
                    style: kMainTextRoboto.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget phoneButton() {
  return Container(
    width: double.infinity,
    height: 46.h,
    decoration: BoxDecoration(
      color: const Color(0xFFF0F0F0),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.phone,
          size: 26.sp,
          color: AppColors.kLightTextColor,
        ),
        Text(
          '+7 495 487 34 66',
          style: kMainTextRoboto.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          width: 40.w,
        ),
      ],
    ),
  );
}

Column whatGetWithYou(String iconPath, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SvgPicture.asset(
        iconPath,
        width: 24.w,
      ),
      SizedBox(
        height: 14.67.h,
      ),
      Text(
        text,
        style: kMainTextRoboto,
      ),
    ],
  );
}

Row textForWorkMode(String dayText, String timeText) {
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

Column workModeTable(BuildContext context) {
  return Column(
    children: [
      textForWorkMode(
        AppLocalizations.of(context)!.monday,
        AppLocalizations.of(context)!.workTime,
      ),
      textForWorkMode(
        AppLocalizations.of(context)!.tuesday,
        AppLocalizations.of(context)!.workTime,
      ),
      textForWorkMode(
        AppLocalizations.of(context)!.wednesday,
        AppLocalizations.of(context)!.workTime,
      ),
      textForWorkMode(
        AppLocalizations.of(context)!.thursday,
        AppLocalizations.of(context)!.workTime,
      ),
      textForWorkMode(
        AppLocalizations.of(context)!.friday,
        AppLocalizations.of(context)!.workTime,
      ),
      textForWorkMode(
        AppLocalizations.of(context)!.saturday,
        AppLocalizations.of(context)!.weekEnd,
      ),
      textForWorkMode(
        AppLocalizations.of(context)!.sunday,
        AppLocalizations.of(context)!.weekEnd,
      ),
    ],
  );
}

Text colorText(String text, String color) {
  return Text(
    text,
    style: kMainTextRoboto.copyWith(
      fontSize: 14.sp,
      color: color == 'red'
          ? AppColors.red.withOpacity(0.6)
          : AppColors.kLightTextColor.withOpacity(0.6),
      fontWeight: FontWeight.w400,
    ),
  );
}
