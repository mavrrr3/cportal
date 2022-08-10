import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/color_service.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/status_badge.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cportal_flutter/common/util/formatter_util.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';

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
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

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
                            if (item.expiresDate != null)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: theme.allertMessage,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    item.description,
                                    style: theme.textTheme.px14Bold.copyWith(
                                      color: theme.allertMessage,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    localizedStrings.before +
                                        FormatterUtil
                                            .declarationCardExpiresDate(
                                          date: item.expiresDate!,
                                        ),
                                    style: theme.textTheme.px12.copyWith(
                                      color: theme.textLight,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.description,
                                    style: theme.textTheme.px12.copyWith(
                                      color: theme.textLight,
                                    ),
                                  ),
                                  Text(
                                    FormatterUtil.declarationCardTime(
                                      date: item.date,
                                    ),
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
                  ),
                ),

                // Бейджи.
                Positioned(
                  left: 12,
                  top: -9,
                  child: StatusBadge(
                    title: item.status,
                    color: ColorService.fromHex(item.statusColor),
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
