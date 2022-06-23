import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/news_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleNewsArticleWeb extends StatelessWidget {
  final ArticleEntity article;

  const SingleNewsArticleWeb({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final DateFormat outputFormat = DateFormat('d MMMM y, H:m', 'ru');

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        if (state is NewsLoaded) {
          List<ArticleEntity> articlesToRecomendations(String id) {
            return state.articles.where((element) => element.id != id).toList();
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DesktopMenu(
                currentIndex: 1,
                onChange: (index) {
                  changePage(context, index);
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
                              GoRouter.of(context).pop();
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.backArrow,
                                  width: 16,
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
                                const SizedBox(height: 24),
                                Text(
                                  article.header,
                                  style: theme.textTheme.px22,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  outputFormat.format(
                                    article.date,
                                  ),
                                  style: theme.textTheme.px12,
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  article.content.toString(),
                                  style: theme.textTheme.px14,
                                ),
                                const SizedBox(height: 40),
                                Wrap(
                                  runSpacing: 16,
                                  spacing: 16,
                                  children: List.generate(
                                    articlesToRecomendations(article.id).length,
                                    (i) {
                                      return GestureDetector(
                                        onTap: () =>
                                            GoRouter.of(context).pushNamed(
                                          NavigationRouteNames.newsArticlePage,
                                          params: {
                                            'fid': articlesToRecomendations(
                                              article.id,
                                            )[i]
                                                .id,
                                          },
                                        ),
                                        child: NewsCardItem(
                                          width: 312,
                                          height: 152,
                                          item: articlesToRecomendations(
                                            article.id,
                                          )[i],
                                        ),
                                      );
                                    },
                                  ),
                                ),
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

        return const SizedBox();
      },
    );
  }
}
