import 'package:flutter/material.dart';
import 'package:cportal_flutter/common/app_colors.dart';

const appBarTheme = AppBarTheme(
  centerTitle: false,
  elevation: 0,
  backgroundColor: Colors.white,
);

ThemeData lightTheme(BuildContext context) => ThemeData.light().copyWith(
      primaryColor: kPrimary,
      backgroundColor: AppColors.blueWhiteColor,
      scaffoldBackgroundColor: AppColors.cardColor,
      appBarTheme: appBarTheme.copyWith(backgroundColor: kAppBarDark),
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme:
          Theme.of(context).textTheme.apply(displayColor: Colors.black54),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
      primaryColor: kPrimary,
      backgroundColor: AppColors.mainBg,
      scaffoldBackgroundColor: AppColors.mainBg,
      appBarTheme: appBarTheme.copyWith(backgroundColor: kAppBarDark),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: Theme.of(context).textTheme.apply(displayColor: Colors.white),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
