import 'package:cportal_flutter/common/app_colors.dart';
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
    final ThemeData theme = Theme.of(context);

    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.textMain.withOpacity(0.2)
            : AppColors.darkOnboardingBG.withOpacity(0.8),
      ),
    );
  }
}
