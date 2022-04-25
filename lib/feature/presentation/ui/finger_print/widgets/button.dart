import 'package:flutter/material.dart';

enum ButtonEnum {
  blue,
  outlined,
  text,
}

class Button {
  // ignore: long-parameter-list
  static ButtonStyleButton factory(
    BuildContext context,
    ButtonEnum type,
    String text,
    Function function,
    Size size,
  ) {
    final ThemeData theme = Theme.of(context);

    switch (type) {
      case ButtonEnum.blue:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: size,
            primary: theme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => function(),
          child: _TextForButton(text, theme.splashColor),
        );
      case ButtonEnum.outlined:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: theme.primaryColor,
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
    final ThemeData theme = Theme.of(context);

    return Text(
      text!,
      style: theme.textTheme.headline5!.copyWith(
        fontWeight: FontWeight.w700,
        color: color ?? theme.primaryColor,
      ),
    );
  }
}
