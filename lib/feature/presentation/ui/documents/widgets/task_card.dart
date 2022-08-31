import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/color_service.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/tasks/task_card_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/card_description.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/status_badge.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final TaskCardEntity item;
  final Function() onTap;
  final double? width;
  const TaskCard({
    Key? key,
    required this.item,
    required this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return OnHover(
      builder: (isHovered) {
        return Opacity(
          opacity: isHovered ? 0.6 : 1,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: width ?? double.infinity,
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.px14Bold,
                            ),
                            const SizedBox(height: 6),
                            CardDescription(
                              description: item.description,
                              descriptionEnum: item.descriptionEnum,
                              date: item.date,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Бейджи.
                Positioned(
                  left: 12,
                  top: -9,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(item.userPhoto != null)
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.network(item.userPhoto!),
                      ),
                      if (item.userPhoto != null)

                      const SizedBox(width: 4),
                      StatusBadge(
                        title: item.status,
                        color: ColorService.declarationStatus(item.status),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
