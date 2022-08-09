import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileSectionItem extends StatelessWidget {
  final String title;
  final String prefixIcon;
  final Widget suffix;
  final VoidCallback onTap;

  const ProfileSectionItem({
    Key? key,
    required this.title,
    required this.prefixIcon,
    required this.suffix,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return InkWell(
      radius: 0,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              prefixIcon,
              color: theme.textLight,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: theme.textTheme.px16Bold,
            ),
            const Spacer(),
            suffix,
          ],
        ),
      ),
    );
  }
}
