import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveUtil {
  final BuildContext context;

  ResponsiveUtil(this.context);

  /// Возвращает симметричный отступ по горизонтали  для веб и планшета,
  /// страницы с блоком справа(события дня, похожие статьи)
  EdgeInsetsGeometry webTabletPaddingWithRightBloc() {
    final width = MediaQuery.of(context).size.width;

    return EdgeInsets.symmetric(
      horizontal: width < 514
          ? 16
          : zeroWidthCondition(context)
              ? 96
              : firstWidthCondition(context)
                  ? (width - 1340) / 2
                  : secondWidthCondition(context)
                      ? (width - 1654) / 2
                      : (width - 1982) / 2,
    );
  }

  /// Возвращает симметричный отступ по горизонтали  для веб и планшета,
  /// страницы без блока справа(события дня, похожие статьи)
  EdgeInsetsGeometry webTabletPadding() {
    final width = MediaQuery.of(context).size.width;

    return EdgeInsets.symmetric(
      horizontal: width < 514
          ? 16
          : zeroWidthCondition(context)
              ? 96
              : firstWidthCondition(context)
                  ? (width - 1340) / 2
                  : secondWidthCondition(context)
                      ? (width - 1340) / 2
                      : (width - 1600) / 2,
    );
  }

  /// Возвращает ширину основного контента для веб и планшета,
  /// страницы с блоком справа(события дня, похожие статьи)
  double widthContentWithRightBloc() {
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

  /// Возвращает ширину основного контента для веб и планшета,
  /// страницы без блока справа(события дня, похожие статьи)
  double widthContent() {
    final width = MediaQuery.of(context).size.width;

    return width < 514
        ? width - 32
        : zeroWidthCondition(context)
            ? width - 192
            : firstWidthCondition(context)
                ? 1296
                : secondWidthCondition(context)
                    ? 1296
                    : thirdWidthCondition(context)
                        ? 1356
                        : width - webTabletPadding().horizontal;
  }

  /// Возвращает ширину блока Поиск на главной странице.
  double searchLineWidth() {
    final width = MediaQuery.of(context).size.width;

    return width < 514
        ? widthContentWithRightBloc()
        : zeroWidthCondition(context)
            ? widthContentWithRightBloc() + 64
            : widthContentWithRightBloc() + webTabletPaddingWithRightBloc().horizontal / 2 + 398;
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
