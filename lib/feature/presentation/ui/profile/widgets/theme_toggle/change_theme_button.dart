import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

/// Button to change theme.
class ChangeThemeButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  /// Create a button to change theme.
  const ChangeThemeButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: SizedBox(
          width: (width - 34) / 3,
          child: Center(
            child: Text(
              text,
              style: theme.textTheme.px12,
            ),
          ),
        ),
      ),
    );
  }
}
