import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class SearchBg extends StatelessWidget {
  final double? width;
  final double? height;

  const SearchBg({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? theme.text?.withOpacity(0.2)
            : theme.barrierColor,
      ),
    );
  }
}
