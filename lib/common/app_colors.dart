import 'package:flutter/material.dart';

class AppColors {
  static const Color mainBgDark = Color(0xFF111315);
  static const Color secondBgDark = Color(0xFF33383F);
  static const Color mainBgLight = Color(0xFFF0F0F0);
  static const Color kLightTextColor = Color(0xFF111315);
  static const Color lightRed = Color(0xFFEEDCDD);

  static const Color red = Color(0xFFDF292F);
  static const Color redDark = Color(0xFFFF6A55);
  static const Color blue = Color(0xFF5284DA);
  static const Color blueDark = Color(0xFF2A85FF);
  static const Color dividerColor = Color(0x32394414);
  static const Color darkOnboardingBG = Color(0xFF1A1D1F);

  static const Color green = Color(0xFF559935);

  static const Color textMain = Color(0xFF282A2D);
  static const Color textDark = Color(0xFFFCFCFC);

  static const Color appBarLight = Color.fromARGB(255, 179, 179, 179);
  static const Color appBarDark = Color(0xFF111111);
  static const Color iconLight = Color(0xFF999999);
}

Color getBarrierColor(ThemeData theme) => theme.brightness == Brightness.light
    ? AppColors.textMain.withOpacity(0.2)
    : AppColors.darkOnboardingBG.withOpacity(0.8);
