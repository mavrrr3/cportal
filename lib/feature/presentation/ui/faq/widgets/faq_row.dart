import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqRow extends StatelessWidget {
  final String title;
  const FaqRow({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: kMainTextRoboto.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              color: AppColors.blue,
              size: 18,
            ),
          ],
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }
}
