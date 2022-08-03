import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';

class ProfileInfoSection extends StatelessWidget {
  final String headline;
  final String text;
  final Color? textColor;
  final double? bottomPadding;
  final bool hasEmail;
  const ProfileInfoSection({
    Key? key,
    required this.headline,
    required this.text,
    this.textColor,
    this.bottomPadding,
    this.hasEmail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headline,
            style: theme.textTheme.px14,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: theme.textTheme.px16.copyWith(
              fontWeight: FontWeight.w700,
              color: hasEmail ? theme.primary : textColor ?? theme.text,
              decoration: hasEmail ? TextDecoration.underline : null,
            ),
          ),
        ],
      ),
    );
  }
}
