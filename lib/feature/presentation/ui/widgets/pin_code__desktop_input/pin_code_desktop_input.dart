import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/pin_code__desktop_input/cursor.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinCodeDesktopInput extends StatefulWidget {
  final TextEditingController codeController;
  final FocusNode codeFocusNode;
  final bool forceErrorState;
  final void Function(String value) onCompleted;

  const PinCodeDesktopInput({
    Key? key,
    required this.codeFocusNode,
    required this.codeController,
    required this.forceErrorState,
    required this.onCompleted,
  }) : super(key: key);

  @override
  State<PinCodeDesktopInput> createState() => _PinCodeDesktopInputState();
}

class _PinCodeDesktopInputState extends State<PinCodeDesktopInput> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final defaultPinTheme = PinTheme(
      width: 44,
      height: 52,
      textStyle: theme.textTheme.px16,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Pinput(
      autofocus: true,
      enabled: true,
      obscureText: true,
      obscuringCharacter: '*',
      separator: const SizedBox(width: 11),
      forceErrorState: widget.forceErrorState,
      useNativeKeyboard: true,
      length: 4,
      controller: widget.codeController,
      focusNode: widget.codeFocusNode,
      defaultPinTheme: defaultPinTheme,
      errorPinTheme: defaultPinTheme.copyWith(
        decoration:
            defaultPinTheme.decoration!.copyWith(color: theme.lightRedPIN),
        textStyle: defaultPinTheme.textStyle!.copyWith(color: theme.red),
      ),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration?.copyWith(
          border: Border.all(color: theme.primary!.withOpacity(0.34)),
        ),
      ),
      cursor: const Cursor(),
      onCompleted: widget.onCompleted,
    );
  }

  @override
  void dispose() {
    widget.codeController.dispose();
    widget.codeFocusNode.dispose();
    super.dispose();
  }
}
