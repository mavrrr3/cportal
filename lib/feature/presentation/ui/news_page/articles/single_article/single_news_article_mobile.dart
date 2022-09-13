import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/widgets/single_news_mobile_appbar.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/widgets/single_article_news_body.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_service.dart';
import 'package:flutter/material.dart';

class SingleNewsArticleMobile extends StatelessWidget {
  final ArticleEntity article;
  final List<ArticleEntity>? articles;

  const SingleNewsArticleMobile({
    Key? key,
    required this.article,
    this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLargerThenTablet(context))
          DesktopMenu(
            currentIndex: 1,
            onChange: (index) {
              MenuService.changePage(context, index);
            },
          ),
        Expanded(
          child: SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SingleNewsMobileAppBar(article: article),

                /// Колонка с контентом статьи.
                SingleArticleNewsBody(
                  article: article,
                  articles: articles,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
