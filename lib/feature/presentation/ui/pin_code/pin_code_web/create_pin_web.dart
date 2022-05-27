import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/header_text.dart';
import 'package:cportal_flutter/feature/presentation/ui/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/feature/presentation/bloc/pin_code_bloc/pin_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/svg_icon.dart';

final _pinController = TextEditingController();

class CreatePinWeb extends StatelessWidget {
  const CreatePinWeb({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PinCodeBloc>(context, listen: false)
        .add(PinCodeCheckEvent());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LoaderWebWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocConsumer<PinCodeBloc, PinCodeState>(
              listener: (context, state) {
                if (state.status == PinCodeInputEnum.done) {
                  // Если ПИН код из базы Hive совпадает с
                  // введеным ПИНом, то редирект на страницу [/main_page]
                  context.goNamed(NavigationRouteNames.mainPage);
                }
              },
              builder: (context, state) {
                return BodyWidget(input: state.status);
              },
            ),
          ],
        ),
        const SizedBox(),
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
        const SizedBox(height: 260),
        HeaderText.factory(
          _pinController,
          input,
          context,
        ),
        if (input == PinCodeInputEnum.repeat)
          const PinCodeRepeat()
        else
          const PinCodeInput(),
      ],
    );
  }
}

class RepeatePinWeb extends StatelessWidget {
  const RepeatePinWeb({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LoaderWebWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            BodyWidget(input: PinCodeInputEnum.repeat),
          ],
        ),
        const SizedBox(),
      ],
    );
  }
}

class PinCodeInput extends StatefulWidget {
  const PinCodeInput({Key? key}) : super(key: key);

  @override
  _PinCodeInputState createState() => _PinCodeInputState();
}

class _PinCodeInputState extends State<PinCodeInput> {
  late FocusNode _pinFocusNode;
  @override
  void initState() {
    super.initState();
    _pinFocusNode = FocusNode();
  }

  // @override
  // void dispose() {
  //   _pinController.dispose();
  //   _pinFocusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final PinCodeBloc pinCodeBloc =
        BlocProvider.of<PinCodeBloc>(context, listen: false);
    final ThemeData theme = Theme.of(context);

    final defaultPinTheme = PinTheme(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.kLightTextColor.withOpacity(0.2)
            : theme.backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return BlocBuilder<PinCodeBloc, PinCodeState>(
      builder: (context, state) {
        return Pinput(
          autofocus: true,
          obscureText: true,
          obscuringWidget: SvgIcon(
            state.isWrongPin ? AppColors.red : AppColors.blue,
            path: 'obscure_symbol.svg',
            width: 16,
          ),
          useNativeKeyboard: true,
          length: 4,
          controller: _pinController,
          focusNode: _pinFocusNode,
          defaultPinTheme: defaultPinTheme,
          separator: const SizedBox(width: 32),
          focusedPinTheme: defaultPinTheme,
          showCursor: false,
          onChanged: (value) {
            pinCodeBloc.add(
              ChangedPinCode(
                status: state.status,
                pinCode: value,
              ),
            );
          },
          onCompleted: (value) {
            pinCodeBloc.add(
              CreatePinCodeSubmit(
                pinCode: value,
                status: state.status,
              ),
            );

            state.cleanField(_pinController);

            const RepeatePinWeb();
          },
        );
      },
    );
  }
}

class PinCodeRepeat extends StatefulWidget {
  const PinCodeRepeat({Key? key}) : super(key: key);

  @override
  _PinCodeRepeatState createState() => _PinCodeRepeatState();
}

class _PinCodeRepeatState extends State<PinCodeRepeat> {
  late TextEditingController _pinRepeatController;

  late FocusNode _pinFocusRepeatNode;

  @override
  void initState() {
    super.initState();
    _pinFocusRepeatNode = FocusNode();
    _pinRepeatController = TextEditingController();
  }

  @override
  void dispose() {
    _pinRepeatController.dispose();
    // _pinFocusNode.dispose();.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PinCodeBloc pinCodeBloc =
        BlocProvider.of<PinCodeBloc>(context, listen: false);
    final ThemeData theme = Theme.of(context);

    final defaultPinTheme = PinTheme(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.kLightTextColor.withOpacity(0.2)
            : theme.backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return BlocBuilder<PinCodeBloc, PinCodeState>(
      builder: (context, state) {
        return Pinput(
          autofocus: true,
          obscureText: true,
          obscuringWidget: SvgIcon(
            state.isWrongPin ? AppColors.red : AppColors.blue,
            path: 'obscure_symbol.svg',
            width: 16,
          ),
          useNativeKeyboard: true,
          length: 4,
          controller: _pinRepeatController,
          focusNode: _pinFocusRepeatNode,
          defaultPinTheme: defaultPinTheme,
          separator: const SizedBox(width: 32),
          focusedPinTheme: defaultPinTheme,
          showCursor: false,
          onChanged: (value) {
            pinCodeBloc.add(
              ChangedPinCode(
                status: state.status,
                pinCode: value,
              ),
            );
          },
          onCompleted: (value) {
            pinCodeBloc.add(
              CreatePinCodeSubmit(
                pinCode: value,
                status: state.status,
              ),
            );

            state.cleanField(_pinRepeatController);
          },
        );
      },
    );
  }
}
