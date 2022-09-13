import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class QuestionMobileLayoutWithAppBar extends StatelessWidget {
  final String title;
  final Widget child;
  final String? icon;
  final VoidCallback? onTapBackButton;

  const QuestionMobileLayoutWithAppBar({
    Key? key,
    required this.title,
    required this.child,
    this.icon,
    this.onTapBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(62),
        child: SafeArea(
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const CircleBorder(),
                    onPressed: onTapBackButton?.call ?? context.pop,
                    minWidth: 36,
                    padding: const EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      icon ?? ImageAssets.backArrow,
                      color: theme.text,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 22),
                Text(
                  title,
                  style: theme.textTheme.header,
                ),
              ],
            ),
          ),
        ),
      ),
      body: child,
    );
  }
}
