import 'package:flutter/material.dart';
import 'package:cportal_flutter/common/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

///Light
ThemeData lightTheme(BuildContext context) => ThemeData(
      brightness: Brightness.light,

      /// Default family
      fontFamily: FontFamilies.roboto,

      /// --- [Color Scheme] ---
      /// [BackGround]
      backgroundColor: AppColors.mainBgLight,
      scaffoldBackgroundColor: AppColors.mainBgLight,

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
      textTheme: Theme.of(context).textTheme.copyWith(
            /// [32 px]
            headline1: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w400,
            ),

            /// [28 px]
            headline2: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w400,
            ),

            /// [17 px]
            headline3: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
            ),

            /// [16 px]
            headline4: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),

            /// [14 px]
            headline5: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),

            /// [12 px]
            headline6: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
    );

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

final kMainTextRusso = GoogleFonts.russoOne(
  textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textMain,
  ),
);

final kMainTextRoboto = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textMain,
  ),
);

final kMainTextInter = GoogleFonts.inter(
  textStyle: TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textMain,
  ),
);
