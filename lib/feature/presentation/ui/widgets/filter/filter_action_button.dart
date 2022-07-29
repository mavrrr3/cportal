import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';

class FilterActionButton extends StatelessWidget {
  final String text;
  final double width;
  final Function() onTap;
  final bool isOutline;

  const FilterActionButton({
    Key? key,
    required this.text,
    required this.width,
    required this.onTap,
    this.isOutline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return OnHover(
      builder: (isHovered) {
        return Opacity(
          opacity: isHovered ? 0.8 : 1,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: isOutline ? Colors.transparent : theme.primary,
                border: isOutline
                    ? Border.all(
                        width: 2,
                        color: theme.primary!,
                      )
                    : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    text,
                    style: theme.textTheme.px16.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isOutline ? theme.primary : theme.white,
                    ),
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
