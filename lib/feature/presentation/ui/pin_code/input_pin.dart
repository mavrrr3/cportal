import 'dart:developer';

import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/custom_keyboard.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';

final pinController = TextEditingController();
final pinFocusNode = FocusNode();

class InputPinPage extends StatelessWidget {
  const InputPinPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PinCodeBloc>(context, listen: false)
        .add(EditPinCodeCheckEvent());

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0.w,
          ),
          child: BlocConsumer<PinCodeBloc, PinCodeState>(
            listener: ((context, state) {
              if (state.status == PinCodeInputEnum.done) {
                // Если ПИН код из базе Hive совпадает с
                // введеным ПИНом, то редирект на страницу [/main_page]
                context.goNamed(NavigationRouteNames.mainPage);
              }
            }),
            builder: ((context, state) {
              log(state.toString());

              switch (state.status) {
                case PinCodeInputEnum.create:
                case PinCodeInputEnum.creating:
                case PinCodeInputEnum.repeatDone:
                  return const BodyWidget(input: PinCodeInputEnum.input);

                case PinCodeInputEnum.wrongInput:
                  return const BodyWidget(
                    input: PinCodeInputEnum.wrongInput,
                  );
                case PinCodeInputEnum.error:
                  return const BodyWidget(
                    input: PinCodeInputEnum.error,
                  );
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ),
        Column(
          children: [
            CustomKeyboard(
              controller: pinController,
              simbolQuantity: 4,
            ),
            SizedBox(height: 52.h),
          ],
        ),
      ],
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
        const PinCodeInput(),
        SizedBox(height: 8.h),
      ],
    );
  }
}

class PinCodeInput extends StatefulWidget {
  const PinCodeInput({
    Key? key,
  }) : super(key: key);

  @override
  _PinCodeInputState createState() => _PinCodeInputState();
}

class _PinCodeInputState extends State<PinCodeInput> {
  // @override
  // void dispose() {
  //   pinController.dispose();
  //   pinFocusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final defaultPinTheme = PinTheme(
      width: 16.w,
      height: 14.h,
      decoration: BoxDecoration(
        color: theme.hoverColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return BlocBuilder<PinCodeBloc, PinCodeState>(
      builder: (context, state) {
        return Pinput(
          obscureText: true,
          obscuringWidget: SvgIcon(
            state.isWrongPin ? theme.errorColor : theme.primaryColor,
            path: 'obscure_symbol.svg',
            width: 16.w,
          ),
          useNativeKeyboard: false,
          length: 4,
          controller: pinController,
          focusNode: pinFocusNode,
          defaultPinTheme: defaultPinTheme,
          separator: SizedBox(width: 32.w),
          focusedPinTheme: defaultPinTheme,
          showCursor: false,
          onChanged: (value) {
            BlocProvider.of<PinCodeBloc>(context, listen: false).add(
              ChangedPinCode(
                status: state.status,
                pinCode: value,
              ),
            );
          },
          onCompleted: (value) {
            if (state.doesItNeedToClean) {
              Future.delayed(
                const Duration(milliseconds: 600),
                () => pinController.text = '',
              );
            }

            BlocProvider.of<PinCodeBloc>(context, listen: false).add(
              InputPinCodeSubmit(
                pinCode: value,
                status: state.status,
              ),
            );
          },
        );
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
        );
      case PinCodeInputEnum.edit:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.enterNewPinCode,
          secondText: AppLocalizations.of(context)!.itWillBeNeedToEnter,
        );
      case PinCodeInputEnum.error:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: AppLocalizations.of(context)!.forgetPin,
          error: AppLocalizations.of(context)!.errorPinCode,
        );
      case PinCodeInputEnum.wrongRepeat:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.repeatPinCode,
          secondText: '',
          error: pinController.text.length == 4
              ? AppLocalizations.of(context)!.pinNotCorrect
              : '',
        );
      case PinCodeInputEnum.input:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: AppLocalizations.of(context)!.forgetPin,
        );
      case PinCodeInputEnum.wrongInput:
        return HeaderTextWidget(
          title: AppLocalizations.of(context)!.inputPinCode,
          secondText: AppLocalizations.of(context)!.forgetPin,
          error: AppLocalizations.of(context)!.errorPinCode,
        );
      default:
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
    final ThemeData theme = Theme.of(context);

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
                  style: theme.textTheme.headline2,
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
              style: theme.textTheme.headline6!.copyWith(
                color: secondText ==
                        AppLocalizations.of(context)!.itWillBeNeedToEnter
                    ? theme.hoverColor
                    : theme.primaryColor,
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
              style:
                  theme.textTheme.headline6!.copyWith(color: theme.errorColor),
            ),
          ],
        ),
      ],
    );
  }
}
