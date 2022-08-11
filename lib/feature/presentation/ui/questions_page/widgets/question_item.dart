import 'dart:math';

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const QuestionItem({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.adaptive(light: theme.white, dark: theme.cardColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.px16Bold,
                ),
              ),
              const SizedBox(width: 8),
              Transform.rotate(
                angle: -pi / 2,
                child: SvgPicture.asset(
                  ImageAssets.arrowDown,
                  color: theme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
