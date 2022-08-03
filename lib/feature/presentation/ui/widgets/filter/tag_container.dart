import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';

class TagContainer extends StatelessWidget {
  final String text;
  final bool isCloseAction;
  final Function()? onTap;

  const TagContainer({
    Key? key,
    required this.text,
    this.isCloseAction = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return OnHover(
      builder: (isHovered) {
        return Opacity(
          opacity: isHovered ? 0.6 : 1,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.text!.withOpacity(0.06),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 1),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text,
                      style: theme.textTheme.px12.copyWith(
                        color: theme.textLight,
                        height: 1.334,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    if (isCloseAction) const SizedBox(width: 4),
                    if (isCloseAction)
                      Icon(
                        Icons.close,
                        color: theme.text!.withOpacity(0.68),
                        size: 14,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
