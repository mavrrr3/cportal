import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionRow extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const QuestionRow({
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: kIsWeb
                  ? width * 0.4
                  : isLargerThenMobile(context)
                      ? width - 400
                      : width - 60,
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style:
                    theme.textTheme.px16.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/question_arrow.svg',
              color: theme.primary,
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
