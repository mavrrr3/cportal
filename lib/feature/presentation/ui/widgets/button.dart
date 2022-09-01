import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class Button {
  // ignore: long-parameter-list
  static ButtonStyleButton factory(
    BuildContext context, {
    required ButtonEnum type,
    required String text,
    required Function() onTap,
    Size size = const Size(double.infinity, 48),
    Color? color,
  }) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    switch (type) {
      case ButtonEnum.filled:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: size,
            backgroundColor: theme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onTap,
          child: _TextForButton(
            text,
            color: theme.brightness == Brightness.light
                ? theme.cardColor
                : theme.text,
          ),
        );
      case ButtonEnum.outlined:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: color ?? theme.primary!,
              width: 2,
            ),
            minimumSize: size,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onTap,
          child: _TextForButton(text),
        );
      case ButtonEnum.text:
        return TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onTap,
          child: _TextForButton(
            text,
            color: color ?? theme.primary,
          ),
        );
    }
  }
}

enum ButtonEnum {
  filled,
  outlined,
  text,
}

class _TextForButton extends StatelessWidget {
  final String? text;
  final Color? color;
  const _TextForButton(
    this.text, {
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Text(
      text!,
      style: theme.textTheme.px16.copyWith(
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}
