import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_template.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_service.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/news_main_mobile.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final DateFormat outputFormat = DateFormat('d MMMM y, H:m', 'ru');

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
                SliverAppBar(
                  backgroundColor: theme.background,
                  expandedHeight: 176,
                  automaticallyImplyLeading: false,
                  leading: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.black!.withOpacity(0.42),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        enableFeedback: false,
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 24,
                        onPressed: () => context.pop(),
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: ExtendedImage.network(
                      '${AppConfig.imagesUrl}/${article.image}',
                      fit: BoxFit.cover,
                      cache: true,
                    ),
                  ),
                ),

                /// Колонка с контентом статьи.
                SliverToBoxAdapter(
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
                                outputFormat.format(
                                  article.date,
                                ),
                                style: theme.textTheme.px12,
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: [
                                  ...List.generate(
                                    article.content.length,
                                    (index) {
                                      return NewsTemplate.factory(
                                        context,
                                        article.content[index],
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        if (articles != null)
                          NewsMainMobile(
                            articles: articles!,
                            currentArticle: article,
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
