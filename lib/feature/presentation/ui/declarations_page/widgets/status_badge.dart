import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final Color color;
  const StatusBadge(
    this.text,
    this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      height: 19,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Center(
          child: Text(
            capitalize(text),
            style: theme.textTheme.bodyText1!.copyWith(
              color: theme.splashColor,
            ),
          ),
        ),
      ),
    );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
