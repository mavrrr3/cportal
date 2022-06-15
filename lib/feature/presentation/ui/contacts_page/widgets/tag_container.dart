import 'package:cportal_flutter/common/custom_theme.dart';
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

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.text!.withOpacity(0.06),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: theme.textTheme.px12.copyWith(
                  color: theme.textLight,
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
    );
  }
}
