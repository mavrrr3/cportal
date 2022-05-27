import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsHorizontalScroll extends StatelessWidget {
  const NewsHorizontalScroll({
    Key? key,
    required this.items,
    this.currentArticle,
    this.isTextVisible = true,
    this.onTap,
  }) : super(key: key);

  final List<ArticleEntity> items;
  final bool isTextVisible;
  final Function(int)? onTap;
  final ArticleEntity? currentArticle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTextVisible)
          Text(
            AppLocalizations.of(context)!.news,
            style: theme.textTheme.headline3,
          ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    ///Условие, чтобы не отрисовывалась новость, которая сейчас открыта
                    if (items[i] != currentArticle)
                      Padding(
                        padding: EdgeInsets.only(
                          right: i != items.length - 1 ? 8 : 20,
                        ),
                        child: NewsCardItem(
                          item: items[i],
                          onTap: () {
                            if (onTap != null) {
                              onTap!(i);
                            }
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

final List<ArticleEntity> listViewMap = [
  newsArticle,
  newsArticle2,
  newsArticle4,
  newsArticle3,
  newsArticle5,
  newsArticle6,
  newsArticle7,
  newsArticle8,
  newsArticle9,
];
