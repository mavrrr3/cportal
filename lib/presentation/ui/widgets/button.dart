import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonEnum {
  blue,
  outlined,
  text,
}

class Button {
  static ButtonStyleButton factory(
    ButtonEnum type,
    String text,
    Function function,
  ) {
    switch (type) {
      case ButtonEnum.blue:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(142.w, 48.h),
            primary: AppColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => function(),
          child: Text(
            text,
            style: kMainTextRoboto.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        );
      case ButtonEnum.outlined:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: AppColors.blue,
              width: 2,
            ),
            minimumSize: Size(142.w, 48.h),
            primary: const Color(0xFFE5E5E5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => function(),
          child: Text(
            text,
            style: kMainTextRoboto.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.blue,
            ),
          ),
        );
      case ButtonEnum.text:
        return TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(142.w, 48.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => function(),
          child: Text(
            text,
            style: kMainTextRoboto.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.blue,
            ),
          ),
        );
    }
  }
}
