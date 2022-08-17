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

  static Color declarationBadge(String status) {
    switch (status) {
      case 'В работе':
        return const Color(0xffCF5AF8);

      case 'Остановлено':
        return const Color(0xffFF6A55);

      case 'Завершено инициатором':
        return const Color(0xff686A6C);
      case 'Завершено':
        return const Color(0xff12B76A);

      default:
        return const Color(0xffCF5AF8);
    }
  }
}
