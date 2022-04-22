import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDataRow extends StatelessWidget {
  final String normalText;
  final String boldText;

  const UserDataRow({
    Key? key,
    required this.normalText,
    required this.boldText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          normalText,
          style: kMainTextRoboto.copyWith(
            fontSize: 14.sp,
            color: AppColors.kLightTextColor.withOpacity(0.68),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          boldText,
          style: kMainTextRoboto.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
