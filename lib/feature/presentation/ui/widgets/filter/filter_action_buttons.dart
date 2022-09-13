import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_action_button.dart';
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
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Применить.
          FilterActionButton(
            text: AppLocalizations.of(context)!.apply,
            width: width,
            onTap: onApply,
          ),

          // Очистить.
          FilterActionButton(
            text: AppLocalizations.of(context)!.clear_all,
            width: width,
            onTap: onClear,
            isOutline: true,
          ),
        ],
      ),
    );
  }
}
