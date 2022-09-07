import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/common/util/responsive_util.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/avatar_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Для теста, в будущем заменить на реальные данные.

class TodayWidget extends StatelessWidget {
  final Function(int) onTap;
  const TodayWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    final title = Text(
      AppLocalizations.of(context)!.today,
      style: theme.textTheme.px22,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        if (isMobile(context))
          Padding(
            padding: getHorizontalPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                title,
                ...List.generate(
                  _items.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        onTap(index);
                      },
                      child: _TodayItem(item: _items[index]),
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          Column(
            children: [
              if (zeroWidthCondition(context)) ...[
                const SizedBox(height: 24),
              ] else ...[
                const SizedBox(height: 6),
              ],
              Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: !zeroWidthCondition(context) ? 366 : double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title,
                        const SizedBox(height: 12),
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 51,
                          runSpacing: 16,
                          children: List.generate(
                            _items.length,
                            (index) => OnHover(
                              builder: (isHovered) {
                                return Opacity(
                                  opacity: isHovered ? 0.6 : 1,
                                  child: _TodayItem(item: _items[index]),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _TodayItem extends StatelessWidget {
  final TodayItemModel item;

  const _TodayItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return SizedBox(
      height: 69,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AvatarBox(
            size: 69,
            imgPath: item.image,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  softWrap: true,
                  item.title ?? AppLocalizations.of(context)!.birthDay,
                  style: theme.textTheme.px14.copyWith(
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.description,
                  softWrap: true,
                  style: theme.textTheme.px14Bold.copyWith(
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (item.post != null)
                      Text(
                        softWrap: true,
                        item.post!,
                        style: theme.textTheme.px12.copyWith(
                          color: theme.textLight,
                        ),
                      ),
                    if (item.place != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.text!.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 4,
                            ),
                            child: Text(
                              softWrap: true,
                              item.place!,
                              style: theme.textTheme.px12.copyWith(
                                color: theme.textLight,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TodayItemModel {
  final String image;
  final String? title;
  final String description;
  final String? post;
  final String? place;

  TodayItemModel({
    required this.image,
    this.title,
    required this.description,
    this.post,
    this.place,
  });
}

final List<TodayItemModel> _items = [
  TodayItemModel(
    image: '20220616/285831712_340931151553303_8302347002848994819_n.jpg',
    description: 'Романова Алексея Игоревича',
    post: 'Охранник',
    place: 'Новосталь-М',
  ),
  TodayItemModel(
    image: '20220616/285831712_340931151553303_8302347002848994819_n.jpg',
    description: 'Новосталь-М',
  ),
  TodayItemModel(
    image: '20220616/285831712_340931151553303_8302347002848994819_n.jpg',
    description: 'Романова Алексея Игоревича',
    post: 'Охранник',
    place: 'Новосталь-М',
  ),
  TodayItemModel(
    image: '20220616/285831712_340931151553303_8302347002848994819_n.jpg',
    description: 'Романова Алексея Игоревича',
    post: 'Охранник',
    place: 'Новосталь-М',
  ),
];
