// ignore_for_file: unused_local_variable
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/news_code_enum.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/scrollable_tabs_widget.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_card.dart';

int _currentIndex = 0;

class NewsPage extends StatelessWidget {
  final NewsCodeEnum pageType;
  final PageController pageController = PageController();

  NewsPage({Key? key, required this.pageType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FetchNewsBloc>(context, listen: false).add(
      const FetchAllNewsEvent(),
    );

    final double width = MediaQuery.of(context).size.width;
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        List<ArticleEntity> articles = [];
        List<ArticleEntity> currentTabArticles = [];

        List<String> categories = [];

        if (state is NewsLoading && state.isFirstFetch) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Center(
              child: PlatformProgressIndicator(),
            ),
          );
        } else if (state is NewsLoading) {
          articles = state.oldArticles;
          if (state.tabs.isNotEmpty) categories = state.tabs;
        } else if (state is NewsLoaded) {
          articles = state.articles;
          if (state.tabs.isNotEmpty) categories = state.tabs;
        }
        if (_currentIndex == 0) currentTabArticles = articles;
        if (_currentIndex != 0) {
          currentTabArticles = articles
              .where((element) => element.category == categories[_currentIndex])
              .toList();
        }
        List<ArticleEntity> sortedArticles(List<ArticleEntity> list) {
          list.sort((a, b) => b.id.compareTo(a.id));

          return list.toSet().toList();
        }

        List<Widget> getWidgets() {
          final List<Widget> list = [];
          int count = 0;
          while (count < categories.length) {
            list.add(Padding(
              padding: getHorizontalPadding(context),
              child: _Content(
                articles: sortedArticles(articles),
                tabs: categories,
              ),
            ));
            count++;
          }

          return list;
        }

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: getHorizontalPadding(context),
                child: Text(
                  AppLocalizations.of(context)!.news,
                  style: theme.textTheme.header,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Категории.
                    ScrollableTabsWidget(
                      currentIndex: _currentIndex,
                      items: categories,
                      onTap: (index) =>
                          _onPageChanged(index, context, categories),
                    ),

                    Expanded(
                      child: Swipe(
                        onSwipeRight: () {
                          if (_currentIndex != 0) {
                            _onPageChanged(
                              _currentIndex - 1,
                              context,
                              categories,
                            );
                          }
                        },
                        onSwipeLeft: () {
                          if (categories.length - 1 != _currentIndex) {
                            _onPageChanged(
                              _currentIndex + 1,
                              context,
                              categories,
                            );
                          }
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: PageView(
                                controller: pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  ...getWidgets(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onPageChanged(
    int index,
    BuildContext context,
    List<String> categories,
  ) {
    _currentIndex = index;
    if (index == 0) {
      context.read<FetchNewsBloc>().add(const FetchAllNewsEvent());
    } else {
      context.read<FetchNewsBloc>().add(FetchNewsEventBy(categories[index]));
    }
    pageController.jumpToPage(index);
  }
}

class _Content extends StatelessWidget {
  final List<ArticleEntity> articles;
  final List<String> tabs;

  final scrollController = ScrollController();

  _Content({
    Key? key,
    required this.articles,
    required this.tabs,
  }) : super(key: key);

  void _setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (_currentIndex == 0) {
            context.read<FetchNewsBloc>().add(const FetchAllNewsEvent());
          } else {
            context
                .read<FetchNewsBloc>()
                .add(FetchNewsEventBy(tabs[_currentIndex]));
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

      if (_currentIndex == 0) {
        return NewsCard(
          width,
          item: article,
          onTap: () => _onArticleSelected(article.id),
        );
      } else if (article.category == tabs[_currentIndex]) {
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
