import 'package:flutter/material.dart';
import 'package:cportal_flutter/common/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

const appBarTheme = AppBarTheme(
  centerTitle: true,
  elevation: 0,
  backgroundColor: Colors.white,
);

class FontFamilies {
  static const String roboto = 'Roboto';
  static const String inter = 'Inter';
  static const String russo = 'Russo One';
}

/// *---* [Light Theme] *---*
ThemeData lightTheme() => ThemeData.light().copyWith(
      brightness: Brightness.light,

      /// --- [Color Scheme] ---
      /// [BackGround]
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: AppColors.mainBgLight,

      /// [White]
      splashColor: Colors.white,

      /// [Blue]
      primaryColor: AppColors.blue,

      /// [Red]
      errorColor: AppColors.red,

      /// [Green]
      focusColor: AppColors.green,

      /// [Light red for PIN]
      hintColor: AppColors.lightRed,

      /// [Divider]
      dividerColor: AppColors.dividerColor.withOpacity(0.08),

      /// [Light Text, also for icons with custom opacity]
      hoverColor: AppColors.kLightTextColor,

      /// [Text]
      cardColor: AppColors.textMain,
      //------

      /// [Other]
      appBarTheme: appBarTheme.copyWith(
        backgroundColor: AppColors.appBarLight,
        titleTextStyle: const TextStyle(color: AppColors.kLightTextColor),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      visualDensity: VisualDensity.adaptivePlatformDensity,

      /// --- [Text Theme]

      textTheme: _getTextTheme(AppColors.textMain),
    );

/// *---* [Dark Theme] *---*
ThemeData darkTheme() => ThemeData.dark().copyWith(
      brightness: Brightness.dark,

      /// --- [Color Scheme] ---
      /// [BackGround]
      backgroundColor: AppColors.secondBgDark,
      scaffoldBackgroundColor: AppColors.mainBgDark,

      /// [White]
      splashColor: const Color(0xFF33383F),

      /// [Blue]
      primaryColor: AppColors.blueDark,

      /// [Red]
      errorColor: AppColors.redDark,

      /// [Green]
      focusColor: AppColors.green,

      /// [Light red for PIN]
      hintColor: const Color(0xFFFF6A55).withOpacity(0.17),

      /// [Divider]
      dividerColor: AppColors.dividerColor.withOpacity(0.08),

      /// [Light Text, also for icons with custom opacity]
      hoverColor: AppColors.textDark,

      /// [Text]
      cardColor: AppColors.textDark,
      //------

      /// [Other]

      appBarTheme: appBarTheme.copyWith(backgroundColor: AppColors.appBarDark),
      iconTheme: const IconThemeData(color: Colors.white),
      visualDensity: VisualDensity.adaptivePlatformDensity,

      /// --- [Text Theme]

      textTheme: _getTextTheme(AppColors.textDark),
    );

TextTheme _getTextTheme(Color textColor) {
  return TextTheme(
    /// [32 px]
    headline1: GoogleFonts.roboto(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),

    /// [28 px]
    headline2: GoogleFonts.russoOne(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),

    /// [22 px]
    headline3: GoogleFonts.roboto(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),

    /// [17 px]
    headline4: GoogleFonts.roboto(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),

    /// [16 px]
    headline5: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),

    /// [14 px]
    headline6: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),

    /// [12 px]
    bodyText1: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: textColor,
    ),

    /// [9 px] BottomBar
    bodyText2: GoogleFonts.inter(
      fontSize: 9,
      fontWeight: FontWeight.w500,
      color: textColor,
    ),
  );
}
