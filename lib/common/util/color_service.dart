import 'dart:math';

import 'package:flutter/material.dart';

class ColorService {
  static Color get randomColor {
    const List<Color> colors = [
      Color(0xFFB1E5FC),
      Color(0xFFFFD88D),
      Color(0xFFB5E4CA),
      Color(0xFFFFBC99),
      Color(0xFFCABDFF),
    ];
    final int random = Random().nextInt(colors.length);

    return colors[random];
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));

    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
