import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class ConnectingCodePage extends StatelessWidget {
  const ConnectingCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFE5E5E5)),
        child: Column(
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
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CellCodeInput(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
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

  @override
  String toStringShort() => 'Rounded With Shadow';
}

class _CellCodeInputState extends State<CellCodeInput> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

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
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        color: const Color.fromRGBO(70, 69, 66, 1),
      ),
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
      separator: SizedBox(width: width / 26),
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
      // showCursor: false,
      // cursor: cursor,
    );
  }
}
