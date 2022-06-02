import 'package:flutter/material.dart';

class CardHorizontalScroll extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  const CardHorizontalScroll({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: 148,
      height: 92,
      decoration: BoxDecoration(
        color: color ?? theme.splashColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              size: 20,
              color: theme.hoverColor.withOpacity(0.68),
            ),
            Text(
              text,
              style: theme.textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
