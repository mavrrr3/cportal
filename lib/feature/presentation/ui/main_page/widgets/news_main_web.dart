import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/news_card_similar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewsMainWeb extends StatelessWidget {
  final List<ArticleEntity> articles;
  const NewsMainWeb({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getHorizontalPadding(context),
      child: Wrap(
        spacing: 16,
        runSpacing: 20,
        children: List.generate(
          AppConfig.numberNewsArticlesOnMain,
          (i) => NewsCardSimilarItem(
            onTap: () => GoRouter.of(context).pushNamed(
              NavigationRouteNames.newsArticlePage,
              params: {'fid': articles[i].id},
            ),
            width: 312,
            height: 152,
            item: articles[i],
          ),
        ),
      ),
    );
  }
}
