import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_template.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_service.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/news/news_card_similar_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/size_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleNewsArticleWeb extends StatelessWidget {
  final ArticleEntity article;
  final List<ArticleEntity>? articles;

  const SingleNewsArticleWeb({
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
        DesktopMenu(
          currentIndex: 1,
          onChange: (index) {
            MenuService.changePage(context, index);
          },
        ),
        SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ResponsiveConstraints(
              constraint: const BoxConstraints(maxWidth: 704),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        context.pop();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.backArrow,
                            color: theme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppLocalizations.of(context)!.news,
                            style: theme.textTheme.px14.copyWith(
                              color: theme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 310,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                '${AppConfig.imagesUrl}/${article.image}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizePadding.height24px,
                          Text(
                            article.header,
                            style: theme.textTheme.px22,
                          ),
                          SizePadding.height12px,
                          Text(
                            outputFormat.format(
                              article.date,
                            ),
                            style: theme.textTheme.px12,
                          ),
                          SizePadding.height24px,
                          NewsTemplate.factory(
                            context,
                            article.content.first,
                          ),
                          const SizedBox(height: 40),
                          if (articles != null)
                            Wrap(
                              runSpacing: 16,
                              spacing: 16,
                              children: List.generate(
                                AppConfig.numberRecomendedArticlesWeb,
                                (i) {
                                  return GestureDetector(
                                    onTap: () => GoRouter.of(context).pushNamed(
                                      NavigationRouteNames.newsArticlePage,
                                      params: {
                                        'fid': articlesToRecomendations(
                                          article.id,
                                        )[i]
                                            .id,
                                      },
                                    ),
                                    child: NewsCardSimilarItem(
                                      width: 312,
                                      height: 152,
                                      item: articlesToRecomendations(
                                        article.id,
                                      )[i],
                                    ),
                                  );
                                },
                              ),
                            )
                          else
                            const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<ArticleEntity> articlesToRecomendations(String id) {
    return articles!.where((element) => element.id != id).toList();
  }
}
