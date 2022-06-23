import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        if (state is NewsLoaded) {
          ArticleEntity articlefromBloc() {
            return state.articles
                .where((element) => element.id == id)
                .toList()
                .first;
          }

          return Swipe(
            onSwipeRight: () {
              if (!kIsWeb) {
                GoRouter.of(context).pop();
              }
            },
            child: Scaffold(
              backgroundColor: theme.background,
              body: kIsWeb
                  ? SingleNewsArticleWeb(
                      article: articlefromBloc(),
                    )
                  : SingleNewsArticleMobile(
                      article: articlefromBloc(),
                      articles: state.articles,
                    ),
            ),
          );
        }

        // TODO: Отработать другие стейты.
        return const SizedBox();
      },
    );
  }
}
