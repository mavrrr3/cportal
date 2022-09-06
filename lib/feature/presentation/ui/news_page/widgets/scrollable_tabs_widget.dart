import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/responsive_util.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ScrollableTabsWidget extends StatefulWidget {
  final List<String> items;
  final int currentIndex;
  final Function(int) onTap;
  final Color? activeColor;

  const ScrollableTabsWidget({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.activeColor,
  }) : super(key: key);

  @override
  State<ScrollableTabsWidget> createState() => _ScrollableTabsWidgetState();
}

class _ScrollableTabsWidgetState extends State<ScrollableTabsWidget> {
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: getHorizontalPadding(context),
          child: SizedBox(
            width: width,
            height: 30,
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
          color: theme.divider,
        ),
      ],
    );
  }

  Widget _textButton(
    CustomTheme theme, {
    required String text,
    required bool isCurrent,
    Function()? onTap,
  }) {
    return OnHover(
      builder: (isHovered) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(
              right: !ResponsiveWrapper.of(context).isLargerThan(TABLET) ? 8.0 : 19,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeIn,
              decoration: BoxDecoration(
                border: isCurrent
                    ? Border(
                        bottom: BorderSide(
                          width: 2.5,
                          color: widget.activeColor ?? theme.primary!,
                        ),
                      )
                    : isHovered
                        ? Border(
                            bottom: BorderSide(
                              width: 2.5,
                              color: theme.text!,
                            ),
                          )
                        : null,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  text,
                  style: isCurrent
                      ? theme.textTheme.px16.copyWith(
                          fontWeight: FontWeight.w700,
                          color: widget.activeColor ?? theme.primary!,
                        )
                      : theme.textTheme.px16.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
