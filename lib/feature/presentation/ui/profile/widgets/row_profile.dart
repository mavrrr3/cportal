import 'package:cportal_flutter/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowProfile extends StatelessWidget {
  final Widget firstWidget;
  final String text;
  final Widget secondWidget;
  const RowProfile({
    Key? key,
    required this.firstWidget,
    required this.text,
    required this.secondWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        firstWidget,
        SizedBox(
          width: 17.w,
        ),
        Text(
          text,
          style: kMainTextRoboto.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
        secondWidget,
      ],
    );
  }
}
