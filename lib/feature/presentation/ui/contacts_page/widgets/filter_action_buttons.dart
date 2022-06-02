import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FilterActionButtons extends StatelessWidget {
  final double width;
  final Function() onApply;
  final Function() onClear;

  /// Кнопки фильтра [Применить, Очистить].
  const FilterActionButtons({
    Key? key,
    required this.width,
    required this.onApply,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Применить.
        _FilterActionButton(
          text: AppLocalizations.of(context)!.apply,
          width: width,
          onTap: onApply,
        ),

        // Очистить.
        _FilterActionButton(
          text: AppLocalizations.of(context)!.clear_all,
          width: width,
          onTap: onApply,
          isOutline: true,
        ),
      ],
    );
  }
}

class _FilterActionButton extends StatelessWidget {
  final String text;
  final double width;
  final Function() onTap;
  final bool isOutline;

  const _FilterActionButton({
    Key? key,
    required this.text,
    required this.width,
    required this.onTap,
    this.isOutline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: isOutline ? Colors.transparent : theme.primaryColor,
          border: isOutline
              ? Border.all(width: 2, color: theme.primaryColor)
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              text,
              style: theme.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w700,
                color: isOutline
                    ? theme.primaryColor
                    : theme.brightness == Brightness.light
                        ? Colors.white
                        : theme.hoverColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
