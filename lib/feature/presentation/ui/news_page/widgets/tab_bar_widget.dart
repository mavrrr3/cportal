import 'package:cportal_flutter/common/util/padding.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class TabBarWidget extends StatefulWidget {
  final String title;
  final List<String> categoryTitle;
  final int currentIndex;
  final Function(int) onTap;
  const TabBarWidget({
    Key? key,
    required this.title,
    required this.categoryTitle,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: getHorizontalPadding(context),
          child: Text(
            widget.title,
            style: theme.textTheme.headline2,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: getHorizontalPadding(context),
          child: SizedBox(
            width: width,
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.categoryTitle.length,
              itemBuilder: (context, index) {
                return _textButton(
                  theme,
                  text: widget.categoryTitle[index],
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
                      color: theme.primaryColor,
                    ),
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              text,
              style: isCurrent
                  ? theme.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.primaryColor,
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
