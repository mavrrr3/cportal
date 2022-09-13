import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/formatter_util.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/news/cached_news_image.dart';
import 'package:flutter/material.dart';

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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: OnHover(
        builder: (isHovered) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNewsImage(
                width: width,
                height: height,
                imgUrl: '${AppConfig.imagesUrl}/${item.image}',
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.header,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: theme.textTheme.px17.copyWith(
                        fontWeight: FontWeight.w800,
                        color: isHovered
                            ? theme.text?.withOpacity(0.6)
                            : theme.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          FormatterUtil.fullDateWithoutSeconds(date: item.date),
                          style: theme.textTheme.px12.copyWith(
                            color: isHovered
                                ? theme.text?.withOpacity(0.6)
                                : theme.text,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
