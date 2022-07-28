import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';

class PhoneButton extends StatelessWidget {
  const PhoneButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light ? theme.background : theme.background?.withOpacity(0.34),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.phone,
            size: 26,
            color: theme.textLight,
          ),
          Text(
            '+7 495 487 34 66',
            style: theme.textTheme.px16.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
