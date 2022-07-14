import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinCodeField extends StatefulWidget {
  final TextEditingController pinCodeController;
  final FocusNode pinCodeFocusNode;
  final void Function(String value) onCompleted;
  final bool forceErrorState;

  const PinCodeField({
    Key? key,
    required this.pinCodeController,
    required this.pinCodeFocusNode,
    required this.onCompleted,
    required this.forceErrorState,
  }) : super(key: key);

  @override
  State<PinCodeField> createState() => _PinCodeFieldState();
}

class _PinCodeFieldState extends State<PinCodeField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Pinput(
      autofocus: true,
      enabled: true,
      forceErrorState: widget.forceErrorState,
      obscureText: true,
      obscuringWidget: Container(
        decoration: BoxDecoration(
          color: widget.forceErrorState ? theme.red : theme.primary,
          shape: BoxShape.circle,
        ),
      ),
      length: 4,
      controller: widget.pinCodeController,
      focusNode: widget.pinCodeFocusNode,
      defaultPinTheme: getDefaultPinTheme(theme),
      focusedPinTheme: getDefaultPinTheme(theme),
      separator: const SizedBox(width: 32),
      showCursor: false,
      onCompleted: widget.onCompleted,
    );
  }

  PinTheme getDefaultPinTheme(CustomTheme theme) {
    return PinTheme(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? theme.textLight?.withOpacity(0.2)
            : theme.background,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  void dispose() {
    widget.pinCodeController.dispose();
    widget.pinCodeFocusNode.dispose();
    super.dispose();
  }
}
