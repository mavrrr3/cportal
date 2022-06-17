// ignore_for_file: unnecessary_cast

import 'dart:developer';

import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NewsTemplate {
  static Widget factory(
    BuildContext context,
    ParagraphEntity paragraph,
  ) {
    final width = MediaQuery.of(context).size.width;
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    log(paragraph.toString());

    switch (paragraph.template) {
      case '1':
        return Text(
          paragraph.content ?? '',
          style: theme.textTheme.px14,
        );
      case '2':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            children: [
              Image(
                image: ExtendedNetworkImageProvider(
                  '${AppConfig.apiUri}/images/${paragraph.image}',
                  cache: true,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                paragraph.imageTitle ?? '',
                style: theme.textTheme.px12,
              ),
            ],
          ),
        );
      case '3':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Container(
            width: width * 0.46,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: FractionalOffset.topCenter,
                image: ExtendedNetworkImageProvider(
                  'http://${AppConfig.apiUri}/images/${paragraph.image}',
                  cache: true,
                ),
              ),
            ),
          ),
        );
      default:
        return Text(paragraph.content ?? '');
    }
  }
}
