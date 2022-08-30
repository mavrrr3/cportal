import 'package:cportal_flutter/common/util/platform_util.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

bool isLargerThenTablet(BuildContext context) {
  return ResponsiveWrapper.of(context).isLargerThan('BIGMOBILE');
}

bool isLargerThenMobile(BuildContext context) {
  return ResponsiveWrapper.of(context).isLargerThan(MOBILE);
}

bool isTablet(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final ratio = size.width / size.height;

  if ((ratio >= 0.74) && (ratio < 1.5)) {
    return true;
  }

  return false;
}

bool isMobile(BuildContext context) {
  final isItTablet = isTablet(context);

  return !isItTablet && kIsMobile;
}

// zeroWidthCondition, firstWidthCondition, secondWidthCondition,
// thirdWidthConditionit is from Figma maket Adaptation bloc
bool zeroWidthCondition(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  return width < 1366;
}

bool firstWidthCondition(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  return width >= 1366 && width < 1694;
}

bool secondWidthCondition(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  return width >= 1694 && width < 2022;
}

bool thirdWidthCondition(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  return width >= 2022;
}

bool is2KWeb(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  return width >= 1694 && width < 2022;
}

bool is4KWeb(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  return width > 2022;
}
