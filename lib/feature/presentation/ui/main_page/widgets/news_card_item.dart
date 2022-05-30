import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsCardItem extends StatelessWidget {
  final ArticleEntity item;
  final double? width;
  final double? height;
  final double? fontSize;
  final Function()? onTap;

  const NewsCardItem({
    Key? key,
    required this.item,
    this.width,
    this.height,
    this.fontSize,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat outputFormat = DateFormat('d MMMM y, H:m', 'ru');
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width ?? 220,
            height: height ?? 106,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: FractionalOffset.topCenter,
                image: ExtendedNetworkImageProvider(
                  item.image,
                  cache: true,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.header,
                  softWrap: true,
                  style: theme.textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      outputFormat.format(item.dateShow),
                      style: theme.textTheme.bodyText1,
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
