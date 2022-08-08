import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';

class ChangeThemeButtonPopup extends StatelessWidget {
  final String text;
  final Function() onTap;

  /// Кнопка для смены темы.
  const ChangeThemeButtonPopup({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return OnHover(
      builder: (isHovered) {
        return Container(
          width: 348 / 3,
          decoration: BoxDecoration(
            border:
                isHovered ? Border.all(color: theme.primary!, width: 2) : null,
            borderRadius: BorderRadius.circular(24),
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                width: 348 / 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: theme.textTheme.px12.copyWith(
                      color: theme.textLight,
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
