import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowProfile extends StatelessWidget {
  final Widget firstWidget;
  final String text;
  final Widget secondWidget;
  final Function? call;
  const RowProfile({
    Key? key,
    required this.firstWidget,
    required this.text,
    required this.secondWidget,
    this.call,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      children: [
        firstWidget,
        SizedBox(
          width: 17.w,
        ),
        Text(
          text,
          style: theme.textTheme.headline5!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
        GestureDetector(
          onTap: () => call != null ? call!() : debugPrint('call = null'),
          child: secondWidget,
        ),
      ],
    );
  }
}
