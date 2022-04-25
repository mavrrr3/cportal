import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardHorizontalScroll extends StatelessWidget {
  final IconData icon;
  final String text;
  const CardHorizontalScroll({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
  }) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: 148.w,
      height: 92.h,
      decoration: BoxDecoration(
        color: color ?? theme.splashColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: theme.hoverColor.withOpacity(0.68),
            ),
            Text(
              text,
              style: theme.textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
