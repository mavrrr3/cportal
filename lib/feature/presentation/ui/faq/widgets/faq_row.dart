import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FaqRow extends StatelessWidget {
  const FaqRow({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: theme.textTheme.headline5!
                .copyWith(fontWeight: FontWeight.w700),
          ),
          SvgPicture.asset(
            'assets/icons/question_arrow.svg',
            width: 8,
          ),
        ],
      ),
    );
  }
}
