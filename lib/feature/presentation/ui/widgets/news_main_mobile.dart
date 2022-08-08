import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/news/news_card_similar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewsMainMobile extends StatelessWidget {
  final List<ArticleEntity> articles;
  final ArticleEntity? currentArticle;

  const NewsMainMobile({
    Key? key,
    required this.articles,
    this.currentArticle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getSingleHorizontalPadding(
          context,
        ),
      ),
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: articles.length,
          itemBuilder: (context, i) {
            return Row(
              children: [
                /// Условие, чтобы не отрисовывалась новость, которая сейчас открыта.
                if (articles[i] != currentArticle)
                  Padding(
                    padding: EdgeInsets.only(
                      right: i != articles.length - 1
                          ? 16
                          : getSingleHorizontalPadding(context),
                    ),
                    child: NewsCardSimilarItem(
                      item: articles[i],
                      onTap: () => GoRouter.of(context).pushNamed(
                        NavigationRouteNames.newsArticlePage,
                        params: {'fid': articles[i].id},
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
