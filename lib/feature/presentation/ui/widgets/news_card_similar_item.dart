import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsCardSimilarItem extends StatelessWidget {
  final ArticleEntity item;
  final double? width;
  final double? height;
  final double? fontSize;
  final Function()? onTap;

  const NewsCardSimilarItem({
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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

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
                  '${AppConfig.imagesUrl}/${item.image}',
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
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  item.header,
                  style: theme.textTheme.px14.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      outputFormat.format(item.date),
                      style: theme.textTheme.px12,
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
