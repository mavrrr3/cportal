import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/pin_code_area.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/keyboard/custom_keyboard.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/auth_mobile_layout.dart';
import 'package:flutter/material.dart';

class PinCodeMobileScreen extends StatelessWidget {
  final TextEditingController pinController;
  final FocusNode pinFocusNode;
  final String firstTitle;
  final String secondTitle;

  const PinCodeMobileScreen({
    Key? key,
    required this.pinController,
    required this.pinFocusNode,
    required this.firstTitle,
    required this.secondTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthMobileLayout(
      child: Column(
        children: [
          PinCodeArea(
            pinController: pinController,
            pinFocusNode: pinFocusNode,
            firstTitle: firstTitle,
            secondTitle: secondTitle,
          ),
          const Spacer(),
          CustomKeyboard(keyboardController: pinController),
        ],
      ),
    );
  }
}
