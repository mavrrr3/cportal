import 'package:cportal_flutter/presentation/go_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/presentation/ui/widgets/custom_keyboard.dart';
import 'package:cportal_flutter/presentation/ui/widgets/svg_icon.dart';

final _pinController = TextEditingController();
final _pinFocusNode = FocusNode();

enum PinCodeInputEnum { create, repeat, input, error }

class PinCodePage extends StatelessWidget {
  const PinCodePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PinCodeBloc>(context, listen: false)
        .add(const PinCodeCheckEvent());

    return Container(
      decoration: const BoxDecoration(color: Color(0xFFE5E5E5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0.w,
            ),
            child: BlocConsumer<PinCodeBloc, PinCodeState>(
              listener: ((context, state) {
                if (state is PinCodeEnteredState) {
                  // Если ПИН код из базе Hive совпадает с
                  // введеным ПИНом, то редирект на страницу [/main_page]
                  context.goNamed(NavigationRouteNames.mainPage);
                }
              }),
              builder: ((context, state) {
                switch (state.runtimeType) {
                  case PinCodeRepeatState:
                    return const BodyWidget(input: PinCodeInputEnum.repeat);
                  case PinCodeCreateState:
                    return const BodyWidget(input: PinCodeInputEnum.create);
                  case PinCodeEnterState:
                    return const BodyWidget(input: PinCodeInputEnum.input);
                  case PinCodeErrorState:
                    return const BodyWidget(input: PinCodeInputEnum.error);
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              }),
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
    );
  }
}

class BodyWidget extends StatelessWidget {
  final PinCodeInputEnum input;
  const BodyWidget({
    Key? key,
    required this.input,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 48.h),
        HeaderText.factory(
          input,
          context,
        ),
        SizedBox(height: 16.h),
        PinCodeInput(error: input == PinCodeInputEnum.error ? true : false),
        SizedBox(height: 8.h),
      ],
    );
  }
}

class PinCodeInput extends StatefulWidget {
  final bool error;
  const PinCodeInput({
    Key? key,
    required this.error,
  }) : super(key: key);

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
        widget.error ? AppColors.red : AppColors.blue,
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
      onChanged: (value) {
        BlocProvider.of<PinCodeBloc>(context, listen: false)
            .add(PinCodeEnteringEvent(pinCodeEntering: value));
      },
      onCompleted: (value) {
        BlocProvider.of<PinCodeBloc>(context, listen: false)
            .add(PicCodeEnteredEvent(pinCode: value));
      },
    );
  }
}

class HeaderText {
  static HeaderTextWidget factory(
    PinCodeInputEnum input,
    BuildContext context,
  ) {
    switch (input) {
      case PinCodeInputEnum.create:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.createPinCode,
          secondText: AppLocalizations.of(context)!.itWillBeNeedToEnter,
        );
      case PinCodeInputEnum.repeat:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.repeatPinCode,
          secondText: ' ',
          // error: AppLocalizations.of(context)!.pinNotCorrect,
        );
      case PinCodeInputEnum.error:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: AppLocalizations.of(context)!.forgetPin,
          error: AppLocalizations.of(context)!.errorPinCode,
        );
      case PinCodeInputEnum.input:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: AppLocalizations.of(context)!.forgetPin,
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
              secondText,
              style: kMainTextRoboto.copyWith(
                fontSize: 14.sp,
                color: AppColors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 66.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error ?? '',
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
