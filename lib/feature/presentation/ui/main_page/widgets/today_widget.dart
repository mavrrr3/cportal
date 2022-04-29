import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

//для теста, в будущем заменить на реальные данные
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
    image: 'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
    description: 'Романова Алексея Игоревича',
    post: 'Охранник',
    place: 'Новосталь-М',
  ),
  TodayItemModel(
    image: 'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
    description: 'Новосталь-М',
  ),
  TodayItemModel(
    image: 'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
    description: 'Романова Алексея Игоревича',
    post: 'Охранник',
    place: 'Новосталь-М',
  ),
  TodayItemModel(
    image: 'https://avatarko.ru/img/kartinka/9/muzhchina_shlyapa_8746.jpg',
    description: 'Романова Алексея Игоревича',
    post: 'Охранник',
    place: 'Новосталь-М',
  ),
];

class TodayWidget extends StatelessWidget {
  const TodayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.today,
          style: theme.textTheme.headline3,
        ),
        const SizedBox(height: 12),
        !ResponsiveWrapper.of(context).isLargerThan(TABLET)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  _items.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _TodayItem(item: _items[index]),
                  ),
                ),
              )
            : Wrap(
                spacing: 51,
                runSpacing: 16,
                children: List.generate(
                  _items.length,
                  (index) => _TodayItem(item: _items[index]),
                ),
              ),
      ],
    );
  }
}

class _TodayItem extends StatelessWidget {
  const _TodayItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final TodayItemModel item;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AvatarBox(
          size: 69,
          imgPath: item.image,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title ?? AppLocalizations.of(context)!.birthDay,
                style: theme.textTheme.headline6,
              ),
              Text(
                item.description,
                softWrap: true,
                style: theme.textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    item.post ?? '',
                    style: theme.textTheme.bodyText1!.copyWith(
                      color: theme.hoverColor.withOpacity(0.68),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          item.place ?? '',
                          style: theme.textTheme.bodyText1!.copyWith(
                            color: theme.hoverColor.withOpacity(0.68),
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
