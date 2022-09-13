import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/formatter_util.dart';
import 'package:cportal_flutter/common/util/responsive_util.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_template.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/news_main_mobile.dart';
import 'package:flutter/material.dart';

class SingleArticleNewsBody extends StatelessWidget {
  final ArticleEntity article;

  final List<ArticleEntity>? articles;

  const SingleArticleNewsBody({
    Key? key,
    required this.article,
    required this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: getHorizontalPadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.header,
                    style: theme.textTheme.px22,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    FormatterUtil.fullDateWithoutSeconds(date: article.date),
                    style: theme.textTheme.px12,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: List.generate(
                      article.content.length,
                      (index) {
                        return NewsTemplate.factory(
                          context,
                          article.content[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            if (articles != null)
              NewsMainMobile(
                articles: articles!,
                currentArticle: article,
              ),
          ],
        ),
      ),
    );
  }
}
