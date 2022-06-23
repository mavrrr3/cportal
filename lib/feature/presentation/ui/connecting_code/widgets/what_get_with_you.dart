import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';
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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 24,
          color: color,
        ),
        const SizedBox(height: 14.67),
        Text(
          text,
          style: theme.textTheme.px16,
        ),
      ],
    );
  }
}
