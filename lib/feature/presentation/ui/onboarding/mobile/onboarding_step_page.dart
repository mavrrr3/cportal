import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/new_employee_entity.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class OnBoardingStepPage extends StatelessWidget {
  final NewEmployeeEntity content;

  const OnBoardingStepPage({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 68),
        Text(
          content.title,
          style: theme.textTheme.header.copyWith(
            height: 1.2857,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content.description,
          style: theme.textTheme.px16.copyWith(
            height: 1.5,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        const SizedBox(height: 64),
        Align(
          alignment: Alignment.center,
          child: ExtendedImage.network(
            '${AppConfig.imagesUrl}/${content.image}',
            fit: BoxFit.cover,
            cache: true,
          ),
        ),
      ],
    );
  }
}
