import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class ConnectingCodeInput extends StatefulWidget {
  final bool useNativeKeyboard;
  final TextEditingController codeController;
  final Widget? cursor;

  const ConnectingCodeInput({
    Key? key,
    this.useNativeKeyboard = false,
    required this.codeController,
    this.cursor,
  }) : super(key: key);

  @override
  State<ConnectingCodeInput> createState() => _ConnectingCodeInputInputState();
}

class _ConnectingCodeInputInputState extends State<ConnectingCodeInput> {
  final _codeFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      final defaultPinTheme = PinTheme(
        width: 44,
        height: 52,
        textStyle: _isWrongCode(state) ? theme.textTheme.px16.copyWith(color: theme.red) : theme.textTheme.px16,
        decoration: BoxDecoration(
          color: _isWrongCode(state) ? theme.lightRedPIN : theme.cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
      );

      return Pinput(
        key: _formKey,
        useNativeKeyboard: widget.useNativeKeyboard,
        length: 6,
        controller: widget.codeController,
        focusNode: _codeFocusNode,
        defaultPinTheme: defaultPinTheme,
        separator: const SizedBox(width: 11),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(color: theme.lightRedPIN),
        ),
        focusedPinTheme: PinTheme(
          width: 52,
          height: 62,
          decoration: BoxDecoration(
            color: _isWrongCode(state) ? theme.lightRedPIN : theme.cardColor,
            borderRadius: BorderRadius.circular(8),
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
        cursor: widget.cursor,
        showCursor: widget.cursor != null,
        onChanged: (value) => context.read<AuthBloc>().add(ChangeAuthCode(value)),
        onCompleted: (value) => context.read<AuthBloc>().add(AuthEventImpl(value)),
      );
    });
  }

  bool _isWrongCode(AuthState state) {
    if (state is ErrorAuthState) {
      return true;
    }

    return false;
  }

  @override
  void dispose() {
    _codeFocusNode.dispose();
    super.dispose();
  }
}
