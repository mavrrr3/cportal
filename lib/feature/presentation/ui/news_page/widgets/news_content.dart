import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewsContent extends StatefulWidget {
  final List<ArticleEntity> _articles;
  final List<String> _tabs;
  final int _currentIndex;

  const NewsContent({
    Key? key,
    required List<ArticleEntity> articles,
    required List<String> tabs,
    required int currentIndex,
  })  : _articles = articles,
        _tabs = tabs,
        _currentIndex = currentIndex,
        super(key: key);

  @override
  State<NewsContent> createState() => _NewsContentState();
}

class _NewsContentState extends State<NewsContent> {
  late final ScrollController _scrollController;
  late final ScrollController _newsController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _newsController = ScrollController();

    _setupScrollController(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _newsController.dispose();
    super.dispose();
  }

  void _setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          if (widget._currentIndex == 0) {
            context.read<FetchNewsBloc>().add(const FetchAllNewsEvent());
          } else {
            context
                .read<FetchNewsBloc>()
                .add(FetchNewsEventBy(widget._tabs[widget._currentIndex]));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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

      if (widget._currentIndex == 0) {
        return NewsCard(
          width,
          item: article,
          onTap: () => _onArticleSelected(article.id),
        );
      } else if (article.category == tabs[widget._currentIndex]) {
        return NewsCard(
          width,
          item: article,
          onTap: () => _onArticleSelected(article.id),
        );
      }

      return const SizedBox();
    }

    return SingleChildScrollView(
      controller: _scrollController,
      dragStartBehavior: DragStartBehavior.down,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (isLargerThenMobile(context))
            Wrap(
              children: List.generate(
                widget._articles.length,
                (index) {
                  return _builderItem(
                    widget._articles,
                    widget._tabs,
                    312,
                    index,
                  );
                },
              ),
            )
          else
            ListView.builder(
              controller: _newsController,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: widget._articles.length,
              itemBuilder: (context, index) {
                return _builderItem(
                  widget._articles,
                  widget._tabs,
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
