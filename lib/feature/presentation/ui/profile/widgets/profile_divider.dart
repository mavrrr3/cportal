import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Divider(
      height: 1,
      // Then changing theme not possible get color from theme, that's why return transparent color.
      color: theme.brightness == Brightness.light
          ? theme.black?.withOpacity(0.08)
          : theme.text?.withOpacity(0.08) ?? Colors.transparent,
      indent: 16,
      endIndent: 16,
    );
  }
}
