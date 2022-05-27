import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:flutter/material.dart';

class NewsHorizontalScroll extends StatelessWidget {
  const NewsHorizontalScroll({
    Key? key,
    required this.items,
    this.currentArticle,
    this.onTap,
  }) : super(key: key);

  final List<ArticleEntity> items;
  final Function(int)? onTap;
  final ArticleEntity? currentArticle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      right: i != items.length - 1
                          ? 8
                          : getSingleHorizontalPadding(context),
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
    );
  }
}
