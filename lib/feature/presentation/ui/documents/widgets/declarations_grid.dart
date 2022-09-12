import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/formatter_util.dart';
import 'package:cportal_flutter/feature/domain/entities/documents/declarations/declaration_card_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/declaration_card_with_status.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeclarationsGrid extends StatelessWidget {
  final List<DeclarationCardEntity> items;
  final DateTime currentDate;

  const DeclarationsGrid({
    super.key,
    required this.items,
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> allGrids = [];
    final List<DeclarationCardEntity> cardsForCurrentDate = [];
    DateTime currentRenderedDate = currentDate;
    if (allGrids.isEmpty) {
      for (final item in items) {
        if (item.date.day != currentRenderedDate.day) {
          allGrids.add(_buildDailyGrid(
            context,
            currentRenderedDate,
            cardsForCurrentDate,
          ));
          currentRenderedDate = item.date;
          cardsForCurrentDate
            ..clear()
            ..add(item);
        } else {
          cardsForCurrentDate.add(item);
        }

        if (item == items.last) {
          allGrids.add(_buildDailyGrid(
            context,
            currentRenderedDate,
            cardsForCurrentDate,
          ));
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...allGrids,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDailyGrid(
    BuildContext context,
    DateTime currentDate,
    List<DeclarationCardEntity> cardsForCurrentDate,
  ) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return cardsForCurrentDate.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                FormatterUtil.dayWithFullMonth(date: currentDate),
                style: theme.textTheme.px12.copyWith(color: theme.textLight),
              ),
              const SizedBox(height: 16),
              Wrap(
                runSpacing: 16,
                spacing: 16,
                children: List.generate(
                  cardsForCurrentDate.length,
                  (i) => DeclarationCardWithStatus(
                    width: 328,
                    item: cardsForCurrentDate[i],
                    onTap: () => context.pushNamed(
                      NavigationRouteNames.declarationInfo,
                      params: {'fid': items[i].id},
                    ),
                  ),
                ),
              ),
            ]),
          )
        : const SizedBox();
  }
}
