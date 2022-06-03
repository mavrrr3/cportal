// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_cubit.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/faq/widgets/faq_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/scrollable_tabs_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:swipe/swipe.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';

int _currentIndex = 0;
NewsCodeEnum _currentType = NewsCodeEnum.news;

class NewsPage extends StatelessWidget {
  final NewsCodeEnum pageType;
  final PageController _pageController = PageController();

  NewsPage({Key? key, required this.pageType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _currentType = pageType;

    final double width = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<FetchNewsCubit, NewsState>(
      builder: (context, state) {
        List<ArticleEntity> articles = [];
        List<String> tabs = [];

        if (state is NewsLoading && state.isFirstFetch) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          );
        } else if (state is NewsLoading) {
          articles = state.oldArticles;
        } else if (state is NewsLoaded) {
          articles = state.articles;
          tabs = state.tabs;
        }

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: getHorizontalPadding(context),
                child: Text(
                  _getPageTitle(context, _currentType),
                  style: theme.textTheme.headline2,
                ),
              ),
              const SizedBox(height: 16),
              // if (state is NewsLoading && state.isFirstFetch) ...[
              //   const Padding(
              //     padding: EdgeInsets.symmetric(vertical: 60),
              //     child: Center(
              //       child: CircularProgressIndicator(
              //         strokeWidth: 3,
              //       ),
              //     ),
              //   ),
              // ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Категории.
                    ScrollableTabsWidget(
                      currentIndex: _currentIndex,
                      items: tabs,
                      onTap: _onPageChanged,
                    ),

                    Expanded(
                      child: Swipe(
                        onSwipeRight: () {
                          if (_currentIndex != 0) {
                            _onPageChanged(_currentIndex - 1);
                          }
                        },
                        onSwipeLeft: () {
                          if (tabs.length - 1 != _currentIndex) {
                            _onPageChanged(_currentIndex + 1);
                          }
                        },
                        child: ResponsiveConstraints(
                          constraint: pageType == NewsCodeEnum.quastion
                              ? const BoxConstraints(maxWidth: 720)
                              : null,
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView(
                                  controller: _pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    // Генерация страниц под все категории.
                                    // ListView.builder(
                                    //   shrinkWrap: true,
                                    //   physics: const BouncingScrollPhysics(),
                                    //   itemCount: tabs.length,
                                    //   itemBuilder: (context, index) {
                                    //     return Padding(
                                    //       padding:
                                    //           getHorizontalPadding(context),
                                    //       child: _content(
                                    //         context,
                                    //         articles,
                                    //         tabs,
                                    //         width,
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
                                    // for (var tab in tabs)
                                    Padding(
                                      padding: getHorizontalPadding(context),
                                      child: _Content(
                                        articles: articles,
                                        tabs: tabs,
                                        pageType: pageType,
                                      ),
                                    ),
                                    Padding(
                                      padding: getHorizontalPadding(context),
                                      child: _Content(
                                        articles: articles
                                            .where((element) =>
                                                element.category ==
                                                tabs[_currentIndex])
                                            .toList(),
                                        tabs: tabs,
                                        pageType: pageType,
                                      ),
                                    ),

                                    // ...List.generate(
                                    //   tabs.length,
                                    //   (index) {
                                    //     return Padding(
                                    //       padding:
                                    //           getHorizontalPadding(context),
                                    //       child: _content(
                                    //         context,
                                    //         articles,
                                    //         tabs,
                                    //         width,
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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

  void _onPageChanged(int index) {
    _currentIndex = index;

    _pageController.jumpToPage(_currentIndex);
  }

  String _getPageTitle(BuildContext context, NewsCodeEnum pageType) {
    return pageType == NewsCodeEnum.quastion
        ? AppLocalizations.of(context)!.questions
        : AppLocalizations.of(context)!.news;
  }
}

class _Content extends StatelessWidget {
  final List<ArticleEntity> articles;
  final List<String> tabs;
  final NewsCodeEnum pageType;
  final scrollController = ScrollController();

  _Content({
    Key? key,
    required this.articles,
    required this.tabs,
    required this.pageType,
  }) : super(key: key);

  void _setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<FetchNewsCubit>().loadNews();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);

    final width = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);

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
      if (pageType == NewsCodeEnum.news) {
        // Распределение по категориям
        // [Новости]

        return _NewsCard(
          width,
          item: articles[index],
          onTap: () => _onArticleSelected(articles[index].id),
        );
      } else {
        // Распределение по категориям
        // [Вопросы]
        if (articles[index].category == tabs[_currentIndex]) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: FaqRow(
              text: articles[index].header,
              onTap: () {
                GoRouter.of(context).pushNamed(
                  NavigationRouteNames.questionArticlePage,
                  params: {'fid': articles[index].id},
                );
              },
            ),
          );
        }
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

          // Контент.
          if (pageType == NewsCodeEnum.news)
            !ResponsiveWrapper.of(context).isLargerThan(TABLET)
                ? ListView.builder(
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
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 78),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 20,
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
                    ),
                  )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return _builderItem(articles, tabs, width, index);
              },
            ),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final double width;
  final ArticleEntity item;
  final Function() onTap;
  const _NewsCard(
    this.width, {
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: NewsCardItem(
          width: width,
          height: 160,
          fontSize: 17,
          item: item,
        ),
      ),
    );
  }
}
