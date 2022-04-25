import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/custom_keyboard.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';

final _pinController = TextEditingController();
final _pinFocusNode = FocusNode();

class CreatePinPage extends StatelessWidget {
  const CreatePinPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PinCodeBloc>(context, listen: false)
        .add(PinCodeCheckEvent());

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
                // Если ПИН код из базы Hive совпадает с
                // введеным ПИНом, то редирект на страницу [/main_page]
                context.goNamed(NavigationRouteNames.mainPage);
              }
            }),
            builder: ((context, state) {
              switch (state.status) {
                case PinCodeInputEnum.create:
                case PinCodeInputEnum.creating:
                  return const BodyWidget(input: PinCodeInputEnum.create);
                case PinCodeInputEnum.repeat:
                case PinCodeInputEnum.repeating:
                  return const BodyWidget(input: PinCodeInputEnum.repeat);

                case PinCodeInputEnum.wrongRepeat:
                  return const BodyWidget(
                    input: PinCodeInputEnum.wrongRepeat,
                  );
                case PinCodeInputEnum.error:
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
          _pinController,
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

    return BlocBuilder<PinCodeBloc, PinCodeState>(
      builder: (context, state) {
        return Pinput(
          obscureText: true,
          obscuringWidget: SvgIcon(
            state.isWrongPin ? AppColors.red : AppColors.blue,
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
            BlocProvider.of<PinCodeBloc>(context, listen: false).add(
              ChangedPinCode(
                status: state.status,
                pinCode: value,
              ),
            );
          },
          onCompleted: (value) {
            BlocProvider.of<PinCodeBloc>(context, listen: false).add(
              CreatePinCodeSubmit(
                pinCode: value,
                status: state.status,
              ),
            );
            if (state.doesItNeedToClean) {
              Future.delayed(
                const Duration(milliseconds: 600),
                () => _pinController.text = '',
              );
            }
          },
        );
      },
    );
  }
}