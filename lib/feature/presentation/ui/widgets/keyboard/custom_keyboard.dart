// ignore_for_file: prefer_null_aware_method_calls

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/keyboard/keyboard_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomKeyboard extends StatelessWidget {
  final TextEditingController keyboardController;
  final Function()? onComplete;

  const CustomKeyboard({
    Key? key,
    required this.keyboardController,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KeyboardNumber(
              number: 1,
              onPressed: (i) => addNumber(context, i),
            ),
            KeyboardNumber(
              number: 2,
              onPressed: (i) => addNumber(context, i),
            ),
            KeyboardNumber(
              number: 3,
              onPressed: (i) => addNumber(context, i),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KeyboardNumber(
              number: 4,
              onPressed: (i) => addNumber(context, i),
            ),
            KeyboardNumber(
              number: 5,
              onPressed: (i) => addNumber(context, i),
            ),
            KeyboardNumber(
              number: 6,
              onPressed: (i) => addNumber(context, i),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KeyboardNumber(
              number: 7,
              onPressed: (i) => addNumber(context, i),
            ),
            KeyboardNumber(
              number: 8,
              onPressed: (i) => addNumber(context, i),
            ),
            KeyboardNumber(
              number: 9,
              onPressed: (i) => addNumber(context, i),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 90),
            KeyboardNumber(
              number: 0,
              onPressed: (i) => addNumber(context, i),
            ),
            SizedBox(
              width: 90,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 60),
                child: MaterialButton(
                  shape: const CircleBorder(),
                  height: 60,
                  onPressed: () {
                    if (keyboardController.text.isNotEmpty) {
                      keyboardController.text = keyboardController.text
                          .substring(0, keyboardController.text.length - 1);
                    }
                  },
                  child: SvgPicture.asset(
                    ImageAssets.backspace,
                    width: 48,
                    height: 60,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void addNumber(BuildContext context, int number) {
    final state = context.read<AuthBloc>().state;

    if (state is WrongPinCode || state is TryAgainLater) {
      keyboardController.clear();
    } else {
      keyboardController.text += number.toString();

      if (onComplete != null) {
        if (keyboardController.text.length == 4) {
          onComplete!();
        }
      }
    }
  }
}
