import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';

class Button {
  // ignore: long-parameter-list
  static ButtonStyleButton factory(
    BuildContext context,
    ButtonEnum type,
    String text,
    Function function,
    Size size,
  ) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    switch (type) {
      case ButtonEnum.blue:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: size,
            primary: theme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => function(),
          child: _TextForButton(
            text,
            theme.brightness == Brightness.light ? theme.cardColor : theme.text,
          ),
        );
      case ButtonEnum.outlined:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: theme.primary!,
              width: 2,
            ),
            minimumSize: size,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => function(),
          child: _TextForButton(text, null),
        );
      case ButtonEnum.text:
        return TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => function(),
          child: _TextForButton(text, null),
        );
    }
  }
}

enum ButtonEnum {
  blue,
  outlined,
  text,
}

class _TextForButton extends StatelessWidget {
  final String? text;
  final Color? color;
  const _TextForButton(
    this.text,
    this.color, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Text(
      text!,
      style: theme.textTheme.px16.copyWith(
        fontWeight: FontWeight.w700,
        color: color ?? theme.primary,
      ),
    );
  }
}
