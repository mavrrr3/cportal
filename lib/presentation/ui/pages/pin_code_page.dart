import 'dart:math';

import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/presentation/ui/widgets/custom_keyboard.dart';
import 'package:cportal_flutter/presentation/ui/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final _pinController = TextEditingController();
final _pinFocusNode = FocusNode();
bool _isRightCode = true;

class PinCodePage extends StatelessWidget {
  final String route;
  const PinCodePage({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        HeaderText.factory(route, context),
                        SizedBox(height: 16.h),
                        const PinCodeInput(),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomKeyboard(
                        controller: _pinController,
                        simbolQuantity: 4,
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

class PinCodeInput extends StatefulWidget {
  const PinCodeInput({Key? key}) : super(key: key);

  @override
  _PinCodeInputState createState() => _PinCodeInputState();
}

class _PinCodeInputState extends State<PinCodeInput> {
  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 16.w,
      height: 14.h,
      decoration: BoxDecoration(
        color: AppColors.kLightTextColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return Pinput(
      obscureText: true,
      obscuringWidget: SvgIcon(
        _isRightCode ? AppColors.blue : AppColors.red,
        path: 'obscure_symbol.svg',
        width: 16.w,
      ),
      useNativeKeyboard: false,
      length: 4,
      controller: _pinController,
      focusNode: _pinFocusNode,
      defaultPinTheme: defaultPinTheme,
      separator: SizedBox(width: 32.w),
      focusedPinTheme: defaultPinTheme,
      showCursor: false,
    );
  }
}

class HeaderText {
  static HeaderTextWidget factory(
    String route,
    BuildContext context,
  ) {
    switch (route) {
      case 'create':
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.createPinCode,
          secondText: AppLocalizations.of(context)!.itWillBeNeedToEnter,
          error: AppLocalizations.of(context)!.pinNotCorrect,
        );
      case 'repeat':
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.repeatPinCode,
          secondText: ' ',
          error: AppLocalizations.of(context)!.pinNotCorrect,
        );
      default:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: 'Забыли ПИН?',
          error: AppLocalizations.of(context)!.pinNotCorrect,
        );
    }
  }
}

class HeaderTextWidget extends StatelessWidget {
  final String title;
  final String secondText;
  final String? error;

  const HeaderTextWidget({
    Key? key,
    required this.title,
    required this.secondText,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  title,
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
            Text(
              _isRightCode ? secondText : '',
              style: kMainTextRoboto.copyWith(
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 66.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isRightCode ? '' : error ?? '',
              style: kMainTextRoboto.copyWith(
                fontSize: 14.sp,
                color: AppColors.red.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
