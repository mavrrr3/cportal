import 'package:flutter/material.dart';
import 'package:cportal_flutter/common/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const appBarTheme = AppBarTheme(
  centerTitle: true,
  elevation: 0,
  backgroundColor: Colors.white,
);

ThemeData lightTheme(BuildContext context) => ThemeData.light().copyWith(
      primaryColor: kPrimary,
      backgroundColor: AppColors.mainBgLight,
      scaffoldBackgroundColor: AppColors.mainBgLight,
      appBarTheme: appBarTheme.copyWith(
        backgroundColor: kAppBarLight,
        titleTextStyle: const TextStyle(color: AppColors.kLightTextColor),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: Theme.of(context).textTheme.apply(displayColor: Colors.black),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
      primaryColor: kPrimary,
      backgroundColor: AppColors.mainBgDark,
      scaffoldBackgroundColor: AppColors.mainBgDark,
      appBarTheme: appBarTheme.copyWith(backgroundColor: kAppBarDark),
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
