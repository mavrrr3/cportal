import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeclarationCardWithStatus extends StatelessWidget {
  final DeclarationEntity item;
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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final timeFormatter = DateFormat('H:mm');

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: width ?? MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.px14.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.currentStep,
                        style: theme.textTheme.px12.copyWith(
                          color: theme.textLight,
                        ),
                      ),
                      Text(
                        timeFormatter.format(item.date),
                        style: theme.textTheme.px12.copyWith(
                          color: theme.textLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Бейдж со статусами "Одобрено, Отклонено, Обработка".
          Positioned(
            left: 12,
            top: -9,
            child: _drawBadgeByStatus(theme, item.status),
          ),
        ],
      ),
    );
  }
}

Widget _drawBadgeByStatus(CustomTheme theme, String status) {
  switch (status) {
    case 'Одобрено':
      return StatusBadge(
        status,
        theme.green,
      );
    case 'Отклонено':
      return StatusBadge(
        status,
        theme.red,
      );
    default:
      return StatusBadge(
        status,
        theme.yellow,
      );
  }
}
