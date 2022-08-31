import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/formatter_util.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/description_enum.dart';
import 'package:flutter/material.dart';

class CardDescription extends StatelessWidget {
  final String description;
  final DescriptionEnum descriptionEnum;
  final DateTime date;

  const CardDescription({
    Key? key,
    required this.description,
    required this.descriptionEnum,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    switch (descriptionEnum) {
      case DescriptionEnum.task:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.red,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              description,
              style: theme.textTheme.px12Bold.copyWith(color: theme.textLight),
            ),
          ],
        );

      case DescriptionEnum.expired:
        return Text(
          description,
          style: theme.textTheme.px12.copyWith(color: theme.allertMessage),
        );

      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              description,
              style: theme.textTheme.px12.copyWith(color: theme.textLight),
            ),
            Text(
              FormatterUtil.hoursAndMinutes(date: date),
              style: theme.textTheme.px12.copyWith(color: theme.textLight),
            ),
          ],
        );
    }
  }
}
