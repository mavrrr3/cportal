import 'package:cportal_flutter/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

final controller = TextEditingController();
final focusNode = FocusNode();

class ConnectingCodePage extends StatelessWidget {
  const ConnectingCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFE5E5E5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      svgIcon('logo_grey.svg', 24.0),
                      svgIcon('qr_code.svg', 24.0),
                    ],
                  ),
                  const SizedBox(height: 31.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Введите \nкод связывания',
                            style: kMainTextRusso.copyWith(
                              fontSize: 28,
                              height: 1.286,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Как получить код связывания?',
                        style: kMainTextRoboto.copyWith(
                          color: const Color(0xFF355A99),
                          fontSize: 14,
                          height: 1.428,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 132),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CellCodeInput(),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: const [
                CustomKeyboard(),
                SizedBox(height: 52),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KeyboardNumber(number: 1),
            KeyboardNumber(number: 2),
            KeyboardNumber(number: 3),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KeyboardNumber(number: 4),
            KeyboardNumber(number: 5),
            KeyboardNumber(number: 6),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KeyboardNumber(number: 7),
            KeyboardNumber(number: 8),
            KeyboardNumber(number: 9),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 90,
              child: MaterialButton(
                onPressed: null,
                child: SizedBox(),
              ),
            ),
            const KeyboardNumber(number: 0),
            SizedBox(
              width: 90,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 60),
                child: MaterialButton(
                  height: 60,
                  onPressed: () {
                    if (controller.text != null && controller.text.length > 0) {
                      controller.text = controller.text
                          .substring(0, controller.text.length - 1);
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/icons/backspace.svg',
                    width: 48,
                    height: 60,
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

Widget svgIcon(path, width) {
  return SvgPicture.asset(
    'assets/icons/$path',
    width: width,
  );
}

class CellCodeInput extends StatefulWidget {
  const CellCodeInput({Key? key}) : super(key: key);

  @override
  _CellCodeInputState createState() => _CellCodeInputState();
}

class _CellCodeInputState extends State<CellCodeInput> {
  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final defaultPinTheme = PinTheme(
      width: 44,
      height: 52,
      textStyle: kMainTextRoboto,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    // Курсор, оставил код на случай если дизайнеры решат его всё таки сделать
    //
    // final cursor = Align(
    //   alignment: Alignment.bottomCenter,
    //   child: Container(
    //     width: 21,
    //     height: 1,
    //     margin: const EdgeInsets.only(bottom: 12),
    //     decoration: BoxDecoration(
    //       color: const Color.fromRGBO(137, 146, 160, 1),
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //   ),
    // );

    return Pinput(
      length: 6,
      controller: controller,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      separator: SizedBox(width: width / 30),
      focusedPinTheme: defaultPinTheme.copyWith(
        width: 52,
        height: 62,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(40, 42, 45, 0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
      showCursor: false,
      // cursor: cursor,
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
        padding: const EdgeInsets.all(8.0),
        onPressed: () {
          controller.text += '$number';
        },
        height: 60,
        child: Text(
          '$number',
          textAlign: TextAlign.center,
          style: kMainTextRoboto.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
