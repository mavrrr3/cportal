import 'package:cportal_flutter/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhatGetWithYou extends StatelessWidget {
  final String iconPath;
  final Color? color;
  final String text;
  const WhatGetWithYou({
    Key? key,
    required this.iconPath,
    this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 24.w,
          color: color,
        ),
        SizedBox(
          height: 14.67.h,
        ),
        Text(
          text,
          style: kMainTextRoboto,
        ),
      ],
    );
  }
}
