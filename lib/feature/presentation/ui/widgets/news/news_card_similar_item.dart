import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/news/cached_news_image.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/size_padding.dart';
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
              SizePadding.height12px,
              SizedBox(
                width: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.header,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: theme.textTheme.px14Bold.copyWith(
                        color: isHovered ? theme.text?.withOpacity(0.6) : theme.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          outputFormat.format(item.date),
                          style: theme.textTheme.px12.copyWith(
                            color: isHovered ? theme.text?.withOpacity(0.6) : theme.text,
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
