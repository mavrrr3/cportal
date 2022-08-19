import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

bool isLargerThenTablet(BuildContext context) {
  return ResponsiveWrapper.of(context).isLargerThan(TABLET);
}

bool isLargerThenMobile(BuildContext context) {
  return ResponsiveWrapper.of(context).isLargerThan(MOBILE);
}

bool isTablet(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  return width > 600 && width <= 1024;
}
