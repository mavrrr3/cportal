import 'package:flutter/material.dart';

class ProfileInfoSection extends StatelessWidget {
  final String headline;
  final String text;
  final Color? textColor;
  final double? bottomPadding;
  const ProfileInfoSection({
    Key? key,
    required this.headline,
    required this.text,
    this.textColor,
    this.bottomPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headline,
            style: theme.textTheme.headline6,
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: theme.textTheme.headline5!.copyWith(
              fontWeight: FontWeight.w700,
              color: textColor ?? theme.cardColor,
            ),
          ),
        ],
      ),
    );
  }
}
