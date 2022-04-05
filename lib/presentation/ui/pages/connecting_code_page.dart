import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/presentation/ui/widgets/custom_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

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
                                  'Введите \nкод связывания',
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
                              'Как получить код связывания?',
                              style: kMainTextRoboto.copyWith(
                                color: const Color(0xFF355A99),
                                fontSize: 14.sp,
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
                              child: Text(
                                'Введенный вами код не верен',
                                style: kMainTextRoboto.copyWith(
                                  color: AppColors.red,
                                ),
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
