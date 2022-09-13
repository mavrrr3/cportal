import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class DeclarationAppBar extends StatelessWidget {
  final String title;
  const DeclarationAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 38),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => context.pop(),
            child: Stack(
              children: [
                SvgPicture.asset(
                  ImageAssets.backArrow,
                  width: 24,
                  color: theme.text,
                ),
                const SizedBox(
                  width: 36,
                  height: 16,
                ),
              ],
            ),
          ),
          Text(
            title,
            style: theme.textTheme.px22,
          ),
        ],
      ),
    );
  }
}
