import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declaration_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeclarationCardWithStatus extends StatelessWidget {
  final DeclarationEntity item;
  final double? width;

  const DeclarationCardWithStatus({
    Key? key,
    required this.item,
     this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.px14.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        item.svgPath,
                        color: theme.textLight,
                        width: 20,
                      ),
                    ],
                  ),
                  Text(
                    item.date,
                    style: theme.textTheme.px12.copyWith(
                      color: theme.textLight,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.number,
                    style: theme.textTheme.px12.copyWith(
                      color: theme.textLight,
                    ),
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
    case 'одобрено':
      return StatusBadge(
        status,
        theme.green,
      );
    case 'отклонено':
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
