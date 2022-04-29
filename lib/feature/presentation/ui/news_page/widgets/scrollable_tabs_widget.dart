import 'package:cportal_flutter/common/util/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScrollableTabsWidget extends StatefulWidget {
  const ScrollableTabsWidget({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.activeColor,
  }) : super(key: key);

  final List<String> items;
  final int currentIndex;
  final Function(int) onTap;
  final Color? activeColor;

  @override
  State<ScrollableTabsWidget> createState() => _ScrollableTabsWidgetState();
}

class _ScrollableTabsWidgetState extends State<ScrollableTabsWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: getHorizontalPadding(context),
          child: SizedBox(
            width: width,
            height: 28.0.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return _textButton(
                  theme,
                  text: widget.items[index],
                  onTap: () {
                    widget.onTap(index);
                  },
                  isCurrent: widget.currentIndex == index,
                );
              },
            ),
          ),
        ),
        Container(
          height: 1,
          color: theme.dividerColor,
        ),
      ],
    );
  }

  Widget _textButton(
    ThemeData theme, {
    required String text,
    required bool isCurrent,
    Function()? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 8.0.w),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeIn,
          decoration: BoxDecoration(
            border: isCurrent
                ? Border(
                    bottom: BorderSide(
                      width: 2.5,
                      color: widget.activeColor ?? theme.primaryColor,
                    ),
                  )
                : null,
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.0.h),
            child: Text(
              text,
              style: isCurrent
                  ? theme.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: widget.activeColor ?? theme.primaryColor,
                    )
                  : theme.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
