import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class UserDataRow extends StatelessWidget {
  final String normalText;
  final String boldText;

  const UserDataRow({
    Key? key,
    required this.normalText,
    required this.boldText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
                                    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          normalText,
          style: theme.textTheme.px14.copyWith(
            color: theme.textLight,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          boldText,
          style: theme.textTheme.px16.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
