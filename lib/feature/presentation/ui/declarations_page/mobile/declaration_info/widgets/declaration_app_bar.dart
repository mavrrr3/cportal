import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 38),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: SvgPicture.asset(
              ImageAssets.backArrow,
              width: 16,
              color: theme.text,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: theme.textTheme.px22,
          ),
        ],
      ),
    );
  }
}
