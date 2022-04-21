import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:flutter/material.dart';

enum ButtonEnum {
  blue,
  outlined,
  text,
}

class Button {
  static ButtonStyleButton factory(
    ButtonEnum type,
    String text,
    Function function,
    Size size,
  ) {
    switch (type) {
      case ButtonEnum.blue:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: size,
            primary: AppColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => function(),
          child: _TextForButton(text, Colors.white),
        );
      case ButtonEnum.outlined:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: AppColors.blue,
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
    return Text(
      text!,
      style: kMainTextRoboto.copyWith(
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.blue,
      ),
    );
  }
}
