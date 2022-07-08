import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_step_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeclarationStep extends StatelessWidget {
  final DeclarationStepEntity item;
  const DeclarationStep({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    final DateFormat dateFormatter = DateFormat('d MMMM yyyy', 'ru');
    final DateFormat timeFormatter = DateFormat('H:m:s');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // SvgPicture.asset(
            //   _getIconPath(item.status),
            //   width: 24,
            // ),
            const SizedBox(width: 16),
            Text(
              item.title,
              style: theme.textTheme.px12,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              dateFormatter.format(item.date),
              style: theme.textTheme.px12.copyWith(color: theme.textLight),
            ),
            const SizedBox(height: 8),
            Text(
              timeFormatter.format(item.date),
              style: theme.textTheme.px12.copyWith(color: theme.textLight),
            ),
          ],
        ),
      ],
    );
  }

  // String _getIconPath(StepStatus status) {
  //   switch (status) {
  //     case StepStatus.done:
  //       return ImageAssets.stepDone;
  //     case StepStatus.declined:
  //       return ImageAssets.stepDeclined;
  //     default:
  //       return ImageAssets.stepInProgress;
  //   }
  // }
}
