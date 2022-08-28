import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomPadding {
  final BuildContext context;

  CustomPadding(this.context);

  EdgeInsetsGeometry webTabletPadding() {
    final width = MediaQuery.of(context).size.width;

    return EdgeInsets.symmetric(
      horizontal: width < 514
          ? 16
          : zeroWidthCondition(context)
              ? 94
              : firstWidthCondition(context)
                  ? (width - 1340) / 2
                  : secondWidthCondition(context)
                      ? (width - 1654) / 2
                      : (width - 1982) / 2,
    );
  }

  double responsiveMainPage() {
    final width = MediaQuery.of(context).size.width;

    return width < 514
        ? width - 32
        : zeroWidthCondition(context)
            ? width - 192
            : firstWidthCondition(context)
                ? 654
                : secondWidthCondition(context)
                    ? 968
                    : thirdWidthCondition(context)
                        ? 1296
                        : width - webTabletPadding().horizontal;
  }

  double searchLineWidth() {
    final width = MediaQuery.of(context).size.width;

    return width < 514
        ? responsiveMainPage()
        : zeroWidthCondition(context)
            ? responsiveMainPage() + 64
            : responsiveMainPage() + webTabletPadding().horizontal / 2 + 398;
  }

  EdgeInsetsGeometry getHorizontalPadding() {
    return EdgeInsets.symmetric(
      horizontal: ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 32 : 16,
    );
  }

  double getSingleHorizontalPadding() {
    return ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 32 : 16;
  }
}

EdgeInsetsGeometry getHorizontalPadding(BuildContext context) {
  return EdgeInsets.symmetric(
    horizontal: ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 32 : 16,
  );
}

double getSingleHorizontalPadding(BuildContext context) {
  return ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 32 : 16;
}
