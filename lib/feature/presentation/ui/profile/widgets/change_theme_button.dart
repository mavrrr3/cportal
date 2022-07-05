import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';

class ChangeThemeButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  /// Кнопка для смены темы.
  const ChangeThemeButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: SizedBox(
          width: (width - 34) / 3,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: theme.textTheme.px12.copyWith(
                color: theme.text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
