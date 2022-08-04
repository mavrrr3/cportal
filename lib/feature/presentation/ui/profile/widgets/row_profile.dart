import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class RowProfile extends StatelessWidget {
  final Widget firstWidget;
  final String text;
  final Widget secondWidget;

  const RowProfile({
    Key? key,
    required this.firstWidget,
    required this.text,
    required this.secondWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Row(
      children: [
        firstWidget,
        const SizedBox(width: 17),
        Text(
          text,
          style: theme.textTheme.px16.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
        secondWidget,
      ],
    );
  }
}
