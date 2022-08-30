import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_box/search_box_row.dart';
import 'package:flutter/material.dart';

class SearchBoxItem extends StatelessWidget {
  final String category;
  final String text;
  final Function()? onTap;

  const SearchBoxItem(
    this.onTap, {
    Key? key,
    required this.category,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

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
