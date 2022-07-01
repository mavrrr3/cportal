import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/connecting_code_input/cursor.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class ConnectingCodeInput extends StatelessWidget {
  final TextEditingController codeController;
  final FocusNode codeFocusNode;
  final bool isDesktop;
  final bool forceErrorState;
  final void Function(String value) onCompleted;

  const ConnectingCodeInput({
    Key? key,
    this.isDesktop = false,
    required this.codeFocusNode,
    required this.codeController,
    required this.forceErrorState,
    required this.onCompleted,
  }) : super(key: key);

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      forceErrorState: forceErrorState,
      useNativeKeyboard: isDesktop,
      length: 6,
      controller: codeController,
      focusNode: codeFocusNode,
      defaultPinTheme: defaultPinTheme,
      errorPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(color: theme.lightRedPIN),
        textStyle: defaultPinTheme.textStyle!.copyWith(color: theme.red),
      ),
      focusedPinTheme: defaultPinTheme.copyWith(
        width: 52,
        height: 62,
        decoration: defaultPinTheme.decoration!.copyWith(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(40, 42, 45, 0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      ),
      cursor: isDesktop ? const Cursor() : null,
      showCursor: isDesktop,
      onCompleted: onCompleted,
    );
  }
}
