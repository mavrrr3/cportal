import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_box/search_box_row.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final bool isAnimation;
  final Duration animationDuration;

  const SearchBox({
    Key? key,
    required this.isAnimation,
    required this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return SafeArea(
      child: Padding(
        padding: isLargerThenTablet(context)
            ? const EdgeInsets.only(left: 32)
            : getHorizontalPadding(context),
        child: AnimatedOpacity(
          duration: animationDuration,
          opacity: isAnimation ? 1 : 0,
          curve: Curves.easeIn,
          child: Padding(
            padding: EdgeInsets.only(
              top: isLargerThenTablet(context) ? 60 : 56,
            ),
            child: AnimatedContainer(
              duration: animationDuration,
              curve: Curves.easeIn,
              width: isLargerThenTablet(context)
                  ? 584
                  : MediaQuery.of(context).size.width,
              height: isAnimation ? 216 : 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.cardColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _SearchBoxItem(
                        () => null,
                        category: 'Вопросы',
                        text: 'Как запросить 2НДФЛ',
                      ),
                      _SearchBoxItem(
                        () => null,
                        category: 'Профиль',
                        text: 'Сменить ПИН',
                      ),
                      _SearchBoxItem(
                        () => null,
                        category: 'Вопросы',
                        text: 'Сменить ПИН',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBoxItem extends StatelessWidget {
  final String category;
  final String text;
  final Function()? onTap;

  const _SearchBoxItem(
    this.onTap, {
    Key? key,
    required this.category,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 8),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: theme.textTheme.px12.copyWith(color: theme.textLight),
            ),
            const SizedBox(height: 4),
            SearchBoxRow(text: text),
          ],
        ),
      ),
    );
  }
}
