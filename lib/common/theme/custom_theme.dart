import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// *---* [Light Theme] *---*.
final light = CustomTheme(
  brightness: Brightness.light,
  background: const Color(0xFFF0F0F0),
  white: const Color(0xFFFFFFFF),
  black: const Color(0xFF000000),
  primary: const Color(0xFF5284DA),
  red: const Color(0xFFDF292F),
  green: const Color(0xFF559935),
  yellow: const Color(0xFFFFBC3B),
  lightRedPIN: const Color(0xFFEEDCDD),
  divider: const Color(0x32394414).withOpacity(0.08),
  cardColor: const Color(0xFFFFFFFF),
  text: const Color(0xFF282A2D),
  textLight: const Color(0xFF282A2D).withOpacity(0.68),
  onBoarding: const Color(0xFF282A2D).withOpacity(0.2),
  barrierColor: const Color(0xFF282A2D).withOpacity(0.2),
  textTheme: _getTextTheme(textColor: const Color(0xFF282A2D)),
);

// *---* [Dark Theme] *---*.
final dark = CustomTheme(
  brightness: Brightness.dark,
  background: const Color(0xFF111315),
  white: const Color(0xFFFFFFFF),
  black: const Color(0xFF000000),
  primary: const Color(0xFF2A85FF),
  red: const Color(0xFFFF6A55),
  green: const Color(0xFF559935),
  yellow: const Color(0xFFFFBC3B),
  lightRedPIN: const Color(0xFFFF6A55).withOpacity(0.17),
  cardColor: const Color(0xFF33383F),
  divider: const Color(0x32394414).withOpacity(0.08),
  text: const Color(0xFFFCFCFC),
  textLight: const Color(0xFFFCFCFC).withOpacity(0.68),
  onBoarding: const Color(0xFF282A2D).withOpacity(0.2),
  barrierColor: const Color(0xFF1A1D1F).withOpacity(0.8),
  textTheme: _getTextTheme(textColor: const Color(0xFFFCFCFC)),
);

CustomTextTheme _getTextTheme({required Color textColor}) => CustomTextTheme(
      // [28 px] Header.
      header: GoogleFonts.russoOne(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.29,
      ),

      // [32 px].
      px32: GoogleFonts.roboto(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),

      // [32 px Medium].
      px32Medium: GoogleFonts.roboto(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        height: 1.17,
        color: textColor,
      ),

      // [22 px].
      px22: GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 1.27,
        color: textColor,
      ),

      // [17 px].
      px17: GoogleFonts.roboto(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.5,
      ),

      px17Bold: GoogleFonts.roboto(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: textColor,
        height: 1.24,
        letterSpacing: 0.5,
      ),

      // [16 px].
      px16: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.25,
        letterSpacing: 0.5,
      ),

      // [16 px Bold].
      px16Bold: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: textColor,
        height: 1.5,
        letterSpacing: 0.5,
      ),

      // [14 px].
      px14: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        color: textColor,
        letterSpacing: 0.25,
      ),

      // [14 px Bold].
      px14Bold: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: textColor,
        height: 1.43,
        letterSpacing: 0.25,
      ),

      // [12 px].
      px12: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.33,
        letterSpacing: 0.25,
      ),

      // [9 px] BottomBar.
      bottomBar: GoogleFonts.inter(
        fontSize: 9,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1.3334,
        letterSpacing: 0.4,
      ),
    );

class CustomTheme extends ThemeExtension<CustomTheme> {
  final Brightness? brightness;
  final Color? background;
  final Color? white;
  final Color? black;
  final Color? primary;
  final Color? red;
  final Color? green;
  final Color? yellow;
  final Color? lightRedPIN;
  final Color? cardColor;
  final Color? divider;
  final Color? text;
  final Color? textLight;
  final Color? onBoarding;
  final Color? barrierColor;
  final CustomTextTheme textTheme;

  CustomTheme({
    this.brightness,
    this.background,
    this.white,
    this.black,
    this.primary,
    this.red,
    this.green,
    this.yellow,
    this.lightRedPIN,
    this.cardColor,
    this.divider,
    this.text,
    this.textLight,
    this.onBoarding,
    this.barrierColor,
    required this.textTheme,
  });

  @override
  // ignore: long-parameter-list
  CustomTheme copyWith({
    Brightness? brightness,
    Color? background,
    Color? white,
    Color? primary,
    Color? red,
    Color? green,
    Color? yellow,
    Color? lightRedPIN,
    Color? cardColor,
    Color? divider,
    Color? text,
    Color? textLight,
    Color? onBoarding,
    Color? barrierColor,
    CustomTextTheme? textTheme,
  }) {
    return CustomTheme(
      brightness: brightness ?? this.brightness,
      background: background ?? this.background,
      white: white ?? this.white,
      primary: primary ?? this.primary,
      red: red ?? this.red,
      green: green ?? this.green,
      yellow: yellow ?? this.yellow,
      lightRedPIN: lightRedPIN ?? this.lightRedPIN,
      cardColor: cardColor ?? this.cardColor,
      divider: divider ?? this.divider,
      text: text ?? this.text,
      textLight: textLight ?? this.textLight,
      onBoarding: onBoarding ?? this.onBoarding,
      barrierColor: barrierColor ?? this.barrierColor,
      textTheme: textTheme ?? this.textTheme,
    );
  }

  @override
  ThemeExtension<CustomTheme> lerp(
    ThemeExtension<CustomTheme>? other,
    double t,
  ) {
    if (other is! CustomTheme) {
      return this;
    }

    return CustomTheme(
      background: Color.lerp(background, other.background, t),
      white: Color.lerp(white, other.white, t),
      primary: Color.lerp(primary, other.primary, t),
      red: Color.lerp(red, other.red, t),
      green: Color.lerp(green, other.green, t),
      yellow: Color.lerp(yellow, other.yellow, t),
      lightRedPIN: Color.lerp(lightRedPIN, other.lightRedPIN, t),
      cardColor: Color.lerp(cardColor, other.cardColor, t),
      divider: Color.lerp(divider, other.divider, t),
      text: Color.lerp(text, other.text, t),
      textLight: Color.lerp(textLight, other.textLight, t),
      onBoarding: Color.lerp(onBoarding, other.onBoarding, t),
      barrierColor: Color.lerp(barrierColor, other.barrierColor, t),
      textTheme: textTheme,
    );
  }
}

class CustomTextTheme {
  final TextStyle header;
  final TextStyle px32;
  final TextStyle px32Medium;
  final TextStyle px22;
  final TextStyle px17;
  final TextStyle px17Bold;
  final TextStyle px16;
  final TextStyle px16Bold;
  final TextStyle px14;
  final TextStyle px14Bold;
  final TextStyle px12;
  final TextStyle bottomBar;

  CustomTextTheme({
    required this.header,
    required this.px32,
    required this.px32Medium,
    required this.px22,
    required this.px17,
    required this.px17Bold,
    required this.px16,
    required this.px16Bold,
    required this.px14,
    required this.px14Bold,
    required this.px12,
    required this.bottomBar,
  });
}
