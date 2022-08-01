import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';

class KeyboardNumber extends StatelessWidget {
  final int number;
  final void Function(int number) onPressed;

  const KeyboardNumber({
    Key? key,
    required this.number,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: MaterialButton(
        padding: const EdgeInsets.all(8),
        onPressed: () => onPressed(number),
        height: 60,
        child: Text(
          '$number',
          textAlign: TextAlign.center,
          style: theme.textTheme.px32Medium,
        ),
      ),
    );
  }
}
