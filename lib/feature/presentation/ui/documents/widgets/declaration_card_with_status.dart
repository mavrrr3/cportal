import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/color_service.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_card_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/card_description.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/status_badge.dart';

import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';

class DeclarationCardWithStatus extends StatelessWidget {
  final DeclarationCardEntity item;
  final Function() onTap;
  final double? width;

  const DeclarationCardWithStatus({
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
                      mainAxisSize: MainAxisSize.min,
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
                  ),
                ),

                // Бейджи.
                Positioned(
                  left: 12,
                  top: -9,
                  child: StatusBadge(
                    title: item.status,
                    color: ColorService.declarationStatus(item.status),
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
