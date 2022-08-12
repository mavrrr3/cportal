import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class ProfileDataItem extends StatelessWidget {
  final String title;
  final String description;

  const ProfileDataItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.px14,
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.px16Bold,
        ),
      ],
    );
  }
}
