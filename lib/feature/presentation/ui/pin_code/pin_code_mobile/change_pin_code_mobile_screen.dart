import 'package:cportal_flutter/feature/presentation/ui/pin_code/widgets/change_pin_code_area.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/keyboard/custom_keyboard.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/auth_mobile_layout.dart';
import 'package:flutter/material.dart';

class ChangePinCodeMobileScreen extends StatelessWidget {
  final TextEditingController pinController;
  final FocusNode pinFocusNode;

  const ChangePinCodeMobileScreen({
    Key? key,
    required this.pinController,
    required this.pinFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthMobileLayout(
      child: Column(
        children: [
          ChangePinCodeArea(
            pinController: pinController,
            pinFocusNode: pinFocusNode,
          ),
          const Spacer(),
          CustomKeyboard(keyboardController: pinController),
        ],
      ),
    );
  }
}
