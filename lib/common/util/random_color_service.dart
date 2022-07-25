import 'dart:math';

import 'package:flutter/material.dart';

class RandomColorService {
  static Color get color {
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
}
