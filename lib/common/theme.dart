import 'package:flutter/material.dart';
import 'package:cportal_flutter/common/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
ThemeData lightTheme() => ThemeData(
      brightness: Brightness.light,

      /// --- [Color Scheme] ---
      /// [BackGround]
      backgroundColor: AppColors.mainBgLight,
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
      //------

      /// [Other]
      appBarTheme: appBarTheme.copyWith(
        backgroundColor: AppColors.appBarLight,
        titleTextStyle: const TextStyle(color: AppColors.kLightTextColor),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      visualDensity: VisualDensity.adaptivePlatformDensity,

      /// --- [Text Theme]
      /// Default family
      fontFamily: FontFamilies.roboto,

      textTheme: TextTheme(
        /// [32 px]
        headline1: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textMain,
        ),

        /// [28 px]
        headline2: TextStyle(
          fontFamily: FontFamilies.russo,
          fontSize: 28.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textMain,
        ),

        /// [22 px]
        headline3: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textMain,
        ),

        /// [17 px]
        headline4: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textMain,
        ),

        /// [16 px]
        headline5: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textMain,
        ),

        /// [14 px]
        headline6: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textMain,
        ),

        /// [12 px]
        bodyText1: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textMain,
        ),

        /// [9 px] BottomBar
        bodyText2: TextStyle(
          fontFamily: FontFamilies.inter,
          fontSize: 9.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textMain,
        ),
      ),
    );

/// *---* [Dark Theme] *---*
ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: AppColors.blue,
      backgroundColor: AppColors.mainBgDark,
      scaffoldBackgroundColor: AppColors.mainBgDark,
      appBarTheme: appBarTheme.copyWith(backgroundColor: AppColors.appBarDark),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: Theme.of(context).textTheme.apply(displayColor: Colors.white),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
