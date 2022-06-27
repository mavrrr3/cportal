import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FaqRow extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const FaqRow({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width - 60,
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.px16.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SvgPicture.asset(
            'assets/icons/question_arrow.svg',
            color: theme.primary,
            width: 8,
          ),
        ],
      ),
    );
  }
}
