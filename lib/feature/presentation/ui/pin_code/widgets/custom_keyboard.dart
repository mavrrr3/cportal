import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

late int _simbolQuantity;
TextEditingController _codeController = TextEditingController();

class CustomKeyboard extends StatelessWidget {
  final int simbolQuantity;
  final TextEditingController controller;
  const CustomKeyboard({
    Key? key,
    required this.controller,
    required this.simbolQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _simbolQuantity = simbolQuantity;
    _codeController = controller;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            KeyboardNumber(number: 1),
            KeyboardNumber(number: 2),
            KeyboardNumber(number: 3),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            KeyboardNumber(number: 4),
            KeyboardNumber(number: 5),
            KeyboardNumber(number: 6),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            KeyboardNumber(number: 7),
            KeyboardNumber(number: 8),
            KeyboardNumber(number: 9),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
         const   SizedBox(
              width: 90,
              child:  MaterialButton(
                onPressed: null,
                child: SizedBox(),
              ),
            ),
            const KeyboardNumber(number: 0),
            SizedBox(
              width: 90,
              child: ConstrainedBox(
                constraints:const BoxConstraints(minWidth: 60),
                child: MaterialButton(
                  height: 60,
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      controller.text = controller.text
                          .substring(0, controller.text.length - 1);
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/icons/backspace.svg',
                    width: 48,
                    height: 60,
                    color: Theme.of(context).brightness == Brightness.dark
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
}

class KeyboardNumber extends StatelessWidget {
  final int number;

  const KeyboardNumber({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: MaterialButton(
        padding: const EdgeInsets.all(8),
        onPressed: () {
          concatTextFieled(number, _codeController);
        },
        height: 60,
        child: Text(
          '$number',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

String concatTextFieled(int number, TextEditingController controller) {
  String text = '';
  if (controller.text.length < _simbolQuantity) {
    controller.text += '$number';
    text = controller.text;
  }

  return text;
}
