import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/color_service.dart';
import 'package:cportal_flutter/common/util/formatter_util.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_info_model/task_status_enum.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_info/declaration_step_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeclarationAction extends StatelessWidget {
  final DeclarationStepEntity item;
  const DeclarationAction({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

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
            crossAxisAlignment: item.status != TaskStatusEnum.expired
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 6),
              SvgPicture.asset(_getIconPath(item.status), width: 20),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getStepDescription(
                      theme: theme,
                      localizedStrings: localizedStrings,
                      taskStatus: item.status,
                    ),
                    _getStepDate(
                      theme: theme,
                      localizedStrings: localizedStrings,
                      taskStatus: item.status,
                    ),
                    if (item.comment.isNotEmpty) const SizedBox(height: 6),
                    if (item.comment.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            localizedStrings.comment,
                            style: theme.textTheme.px12.copyWith(
                              color: theme.textLight,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                          Text(
                            item.comment,
                            style: theme.textTheme.px12.copyWith(
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getStepDescription({
    required CustomTheme theme,
    required AppLocalizations localizedStrings,
    required TaskStatusEnum taskStatus,
  }) {
    if (taskStatus == TaskStatusEnum.expired) {
      return Text(
        '${item.description} ${localizedStrings.taskExpired} ${FormatterUtil.expiredDays(localizedStrings: localizedStrings, date: item.descriptionDate)}',
        style: theme.textTheme.px12.copyWith(
          color: theme.red,
          leadingDistribution: TextLeadingDistribution.even,
        ),
      );
    }

    return Text(
      item.description,
      style: theme.textTheme.px12,
    );
  }

  String _getIconPath(TaskStatusEnum taskStatus) {
    switch (taskStatus) {
      case TaskStatusEnum.expired:
        return ImageAssets.stepExpired;
      case TaskStatusEnum.finished:
        return ImageAssets.stepDone;
      case TaskStatusEnum.finishedWithComment:
        return ImageAssets.stepDoneWithComment;
      case TaskStatusEnum.notAgreed:
        return ImageAssets.stepDeclined;
      default:
        return ImageAssets.stepInProgress;
    }
  }

  Widget _getStepDate({
    required CustomTheme theme,
    required TaskStatusEnum taskStatus,
    required AppLocalizations localizedStrings,
  }) {
    if (taskStatus == TaskStatusEnum.inProccess) {
      return Text(
        '${localizedStrings.before} ${FormatterUtil.dateWithExpirationDate(date: item.descriptionDate)}',
        style: theme.textTheme.px12.copyWith(
          color: theme.textLight,
          leadingDistribution: TextLeadingDistribution.even,
        ),
      );
    } else if (taskStatus == TaskStatusEnum.expired) {
      return const SizedBox();
    } else {
      return Text(
        FormatterUtil.fullDate(date: item.descriptionDate),
        style: theme.textTheme.px12.copyWith(
          color: theme.textLight,
          leadingDistribution: TextLeadingDistribution.even,
        ),
      );
    }
  }
}
