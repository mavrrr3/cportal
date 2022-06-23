import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      backgroundColor: theme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: BlocConsumer<PinCodeBloc, PinCodeState>(
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
          ),
          Column(
            children: [
              CustomKeyboard(
                controller: _pinController,
                simbolQuantity: 4,
              ),
              const SizedBox(height: 52),
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
        const SizedBox(height: 48),
        HeaderText.factory(
          _pinController,
          input,
          context,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 8),
          child: PinCodeInput(),
        ),
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
  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PinCodeBloc pinCodeBloc =
        BlocProvider.of<PinCodeBloc>(context, listen: false);
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    final defaultPinTheme = PinTheme(
      width: 16,
      height: 14,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? theme.textLight?.withOpacity(0.2)
            : theme.background,
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
            width: 16,
          ),
          useNativeKeyboard: false,
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
          },
        );
      },
    );
  }
}
