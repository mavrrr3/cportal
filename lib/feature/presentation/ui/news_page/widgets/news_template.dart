import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/size_padding.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NewsTemplate {
  static Widget factory(
    BuildContext context,
    ParagraphEntity paragraph,
  ) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).extension<CustomTheme>()!;
    const padding32verical = EdgeInsets.symmetric(vertical: 32);
    final image = ExtendedNetworkImageProvider(
      '${AppConfig.imagesUrl}/${paragraph.image}',
      cache: true,
    );

    switch (paragraph.template) {
      case 'Изображение с подписью':
        return Padding(
          padding: padding32verical,
          child: Column(
            children: [
              Image(image: image),
              SizePadding.height12px,
              Text(
                paragraph.imageTitle ?? '',
                style: theme.textTheme.px12,
              ),
            ],
          ),
        );
      case 'Изображение без подписи':
        return Padding(
          padding: padding32verical,
          child: Container(
            width: width * 0.46,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: FractionalOffset.topCenter,
                image: image,
              ),
            ),
          ),
        );
      default:
        return Text(paragraph.content ?? '', style: theme.textTheme.px14);
    }
  }
}
