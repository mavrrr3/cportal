import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

bool isLargerThenTablet(BuildContext context) {
  return ResponsiveWrapper.of(context).isLargerThan(TABLET);
}

bool isLargerThenMobile(BuildContext context) {
  return ResponsiveWrapper.of(context).isLargerThan(MOBILE);
}
