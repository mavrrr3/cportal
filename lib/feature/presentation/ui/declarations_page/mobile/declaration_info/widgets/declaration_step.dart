import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/color_service.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_info_model/declaration_step_status_enum.dart';
import 'package:cportal_flutter/feature/data/models/declarations/description_enum.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info/declaration_step_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DeclarationStep extends StatelessWidget {
  final DeclarationStepEntity item;
  const DeclarationStep({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    final dateFormatter = DateFormat('d MMMM yyyy', 'ru');
    final timeFormatter = DateFormat('H:m:s');

    return Container(
      padding: const EdgeInsets.fromLTRB(6, 6, 12, 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ProfileImage(
                fullName: item.responsibleName,
                imgLink: item.responsibleImage,
                color: ColorService.randomColor,
                size: 32,
                borderRadius: 6,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.responsibleName,
                    style: theme.textTheme.px12.copyWith(
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  Text(
                    item.responsiblePosition,
                    style: theme.textTheme.px12.copyWith(
                      color: theme.textLight,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: theme.black!.withOpacity(0.08),
            ),
            height: 1,
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: item.status != DeclarationStepStatusEnum.expired
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 6),
              SvgPicture.asset(_getIconPath(item.status), width: 20),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getStepDescription(
                    theme: theme,
                    descriptionEnum: DescriptionEnum.expired,
                  ),
                  Text(
                    '20 августа',
                    style: theme.textTheme.px12.copyWith(
                      color: theme.textLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getStepDescription({
    required CustomTheme theme,
    required DescriptionEnum descriptionEnum,
  }) {
    switch (descriptionEnum) {
      case DescriptionEnum.expired:
        return Text(
          'item.description',
          style: theme.textTheme.px12.copyWith(color: theme.red),
        );
      default:
        return Text(
          item.description,
          style: theme.textTheme.px12,
        );
    }
  }

  String _getIconPath(DeclarationStepStatusEnum status) {
    switch (status) {
      case DeclarationStepStatusEnum.expired:
        return ImageAssets.stepDeclined;
      case DeclarationStepStatusEnum.completed:
        return ImageAssets.stepDeclined;
      case DeclarationStepStatusEnum.completedWithComment:
        return ImageAssets.stepDeclined;
      case DeclarationStepStatusEnum.declined:
        return ImageAssets.stepDeclined;
      default:
        return ImageAssets.stepInProgress;
    }
  }
}
