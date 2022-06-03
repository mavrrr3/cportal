import 'package:flutter/material.dart';

class UserDataRow extends StatelessWidget {
  final String normalText;
  final String boldText;

  const UserDataRow({
    Key? key,
    required this.normalText,
    required this.boldText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          normalText,
          style: theme.textTheme.headline6!.copyWith(
            color: theme.hoverColor.withOpacity(0.68),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          boldText,
          style: theme.textTheme.headline5!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
