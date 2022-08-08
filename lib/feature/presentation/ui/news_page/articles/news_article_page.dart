import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/single_article/single_news_article_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/single_article/single_news_article_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';

class NewsArticlePage extends StatelessWidget {
  final String id;
  const NewsArticlePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late ArticleEntity? singleArticle;

    final state = context.watch<FetchNewsBloc>().state;
    if (state is NewsLoaded) {
      singleArticle = state.singleArticle(id);
    }

    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      backgroundColor: theme.background,
      body: singleArticle != null
          ? BlocBuilder<FetchNewsBloc, FetchNewsState>(
              builder: (context, state) {
                if (state is NewsLoaded) {
                  return Swipe(
                    onSwipeRight: () {
                      if (!kIsWeb) {
                        context.pop();
                      }
                    },
                    child: kIsWeb
                        ? SingleNewsArticleWeb(
                            article: singleArticle!,
                            articles: state.articles,
                          )
                        : SingleNewsArticleMobile(
                            article: singleArticle!,
                            articles: state.articles,
                          ),
                  );
                }

                // TODO: Отработать другие стейты.
                return const SizedBox();
              },
            )
          : BlocBuilder<GetSingleNewsBloc, GetSingleNewsState>(
              builder: (context, state) {
                if (state is GetSingleNewsLoadedState) {
                  return Swipe(
                    onSwipeRight: () {
                      if (!kIsWeb) {
                        context.pop();
                      }
                    },
                    child: kIsWeb
                        ? SingleNewsArticleWeb(
                            article: state.singleNews,
                          )
                        : SingleNewsArticleMobile(
                            article: state.singleNews,
                          ),
                  );
                }

                // TODO: Отработать другие стейты.
                return const SizedBox();
              },
            ),
    );
  }
}
