import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewsContent extends StatelessWidget {
  final List<ArticleEntity> articles;
  final List<String> tabs;
  final int currentIndex;

  final scrollController = ScrollController();

  NewsContent({
    Key? key,
    required this.articles,
    required this.tabs,
    required this.currentIndex,
  }) : super(key: key);

  void _setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (currentIndex == 0) {
            context.read<FetchNewsBloc>().add(const FetchAllNewsEvent());
          } else {
            context
                .read<FetchNewsBloc>()
                .add(FetchNewsEventBy(tabs[currentIndex]));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);

    final width = MediaQuery.of(context).size.width;

    void _onArticleSelected(String id) {
      GoRouter.of(context).pushNamed(
        NavigationRouteNames.newsArticlePage,
        params: {'fid': id},
      );
    }

    Widget _builderItem(
      List<ArticleEntity> articles,
      List<String> tabs,
      double width,
      int index,
    ) {
      final article = articles[index];

      if (currentIndex == 0) {
        return NewsCard(
          width,
          item: article,
          onTap: () => _onArticleSelected(article.id),
        );
      } else if (article.category == tabs[currentIndex]) {
        return NewsCard(
          width,
          item: article,
          onTap: () => _onArticleSelected(article.id),
        );
      }

      return const SizedBox();
    }

    return SingleChildScrollView(
      controller: scrollController,
      dragStartBehavior: DragStartBehavior.down,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (isLargerThenMobile(context))
            Wrap(
              children: List.generate(
                articles.length,
                (index) {
                  return _builderItem(
                    articles,
                    tabs,
                    312,
                    index,
                  );
                },
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return _builderItem(
                  articles,
                  tabs,
                  width,
                  index,
                );
              },
            ),
        ],
      ),
    );
  }
}
