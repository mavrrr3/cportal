import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

EdgeInsetsGeometry getPagePadding(BuildContext context) {
  return EdgeInsets.symmetric(
    horizontal: ResponsiveWrapper.of(context).isLargerThan(TABLET) ? 32 : 16,
    vertical: ResponsiveWrapper.of(context).isLargerThan(TABLET) ? 16 : 13,
  );
}

EdgeInsetsGeometry getHorizontalPadding(BuildContext context) {
  return EdgeInsets.symmetric(
    horizontal: ResponsiveWrapper.of(context).isLargerThan(TABLET) ? 32 : 16,
  );
}
