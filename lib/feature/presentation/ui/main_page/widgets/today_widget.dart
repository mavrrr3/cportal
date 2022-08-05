import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/avatar_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

// Для теста, в будущем заменить на реальные данные.

class TodayWidget extends StatelessWidget {
  final Function(int) onTap;
  const TodayWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.today,
          style: theme.textTheme.px22,
        ),
        const SizedBox(height: 12),
        if (!ResponsiveWrapper.of(context).isLargerThan(TABLET))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
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
          )
        else
          Wrap(
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

    return Row(
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
            children: [
              Text(
                item.title ?? AppLocalizations.of(context)!.birthDay,
                style: theme.textTheme.px14,
              ),
              const SizedBox(height: 7),
              Text(
                item.description,
                softWrap: true,
                style: theme.textTheme.px14.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (item.post != null)
                    Text(
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
