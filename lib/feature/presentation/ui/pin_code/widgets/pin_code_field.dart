import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinCodeField extends StatelessWidget {
  final TextEditingController pinCodeController;
  final FocusNode pinCodeFocusNode;
  final void Function(String value) onCompleted;
  final bool useNativeKeyboard;
  final bool forceErrorState;

  const PinCodeField({
    Key? key,
    required this.pinCodeController,
    required this.pinCodeFocusNode,
    required this.onCompleted,
    this.useNativeKeyboard = false,
    required this.forceErrorState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Pinput(
      forceErrorState: forceErrorState,
      obscureText: true,
      obscuringWidget: Container(
        decoration: BoxDecoration(
          color: forceErrorState ? theme.red : theme.primary,
          shape: BoxShape.circle,
        ),
      ),
      useNativeKeyboard: useNativeKeyboard,
      length: 4,
      controller: pinCodeController,
      focusNode: pinCodeFocusNode,
      defaultPinTheme: getDefaultPinTheme(theme),
      focusedPinTheme: getDefaultPinTheme(theme),
      separator: const SizedBox(width: 32),
      showCursor: false,
      onCompleted: onCompleted,
    );
  }

  PinTheme getDefaultPinTheme(CustomTheme theme) {
    return PinTheme(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light ? theme.textLight?.withOpacity(0.2) : theme.background,
        shape: BoxShape.circle,
      ),
    );
  }
}