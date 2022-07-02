import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/keyboard/keyboard_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomKeyboard extends StatelessWidget {
  final TextEditingController keyboardController;

  const CustomKeyboard({
    Key? key,
    required this.keyboardController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KeyboardNumber(
              number: 1,
              onPressed: addNumber,
            ),
            KeyboardNumber(
              number: 2,
              onPressed: addNumber,
            ),
            KeyboardNumber(
              number: 3,
              onPressed: addNumber,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KeyboardNumber(
              number: 4,
              onPressed: addNumber,
            ),
            KeyboardNumber(
              number: 5,
              onPressed: addNumber,
            ),
            KeyboardNumber(
              number: 6,
              onPressed: addNumber,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KeyboardNumber(
              number: 7,
              onPressed: addNumber,
            ),
            KeyboardNumber(
              number: 8,
              onPressed: addNumber,
            ),
            KeyboardNumber(
              number: 9,
              onPressed: addNumber,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 90),
            KeyboardNumber(
              number: 0,
              onPressed: addNumber,
            ),
            SizedBox(
              width: 90,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 60),
                child: MaterialButton(
                  height: 60,
                  onPressed: () {
                    if (keyboardController.text.isNotEmpty) {
                      keyboardController.text =
                          keyboardController.text.substring(0, keyboardController.text.length - 1);
                    }
                  },
                  child: SvgPicture.asset(
                    ImageAssets.backspace,
                    width: 48,
                    height: 60,
                    color: theme.brightness == Brightness.dark ? Colors.white : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void addNumber(int number) => keyboardController.text += number.toString();
}
