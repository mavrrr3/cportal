import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String title;
  final Color color;
  const StatusBadge({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Container(
        height: 19,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Center(
            child: Text(
              capitalize(title),
              style: theme.textTheme.px12.copyWith(
                color: theme.white,
                letterSpacing: -0.4,
                fontWeight: FontWeight.w500,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
