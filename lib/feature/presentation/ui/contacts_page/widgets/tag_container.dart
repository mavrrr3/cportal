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
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.hoverColor.withOpacity(0.06),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: theme.textTheme.bodyText1!.copyWith(
                  color: theme.hoverColor.withOpacity(0.68),
                ),
              ),
              if (isCloseAction) const SizedBox(width: 4),
              if (isCloseAction)
                Icon(
                  Icons.close,
                  color: theme.cardColor.withOpacity(0.68),
                  size: 14,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
