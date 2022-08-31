import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateDeclarations extends StatelessWidget {
  final List<Widget> items;
  final Function(int) onTap;
  const CreateDeclarations({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.createDeclaration,
          style: theme.textTheme.px32,
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: List.generate(
            items.length,
            (index) => GestureDetector(
              onTap: () => onTap(index),
              child: items[index],
            ),
          ),
        ),
      ],
    );
  }
}
