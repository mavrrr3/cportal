// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:swipe/swipe.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/news_code_enum.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/faq/widgets/faq_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/scrollable_tabs_widget.dart';

int _currentIndex = 0;
NewsCodeEnum _currentType = NewsCodeEnum.news;

class QuastionsPage extends StatelessWidget {
  final NewsCodeEnum pageType;
  final PageController _pageController = PageController();

  QuastionsPage({Key? key, required this.pageType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _currentType = pageType;

    BlocProvider.of<FetchNewsBloc>(context, listen: false).add(
      const FetchQaustionsEvent(),
    );

    final double width = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        List<ArticleEntity> articles = [];
        List<ArticleEntity> currentTabArticles = [];

        List<String> tabs = [];

        if (state is QuastionsLoading && state.isFirstFetch) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          );
        } else if (state is QuastionsLoading) {
          articles = state.oldArticles;
          tabs = state.tabs;
        } else if (state is QaustionsLoaded) {
          articles = state.articles;
          tabs = state.tabs;
        }
        if (_currentIndex == 0) currentTabArticles = articles;
        if (_currentIndex != 0) {
          currentTabArticles = articles
              .where((element) => element.category == tabs[_currentIndex])
              .toList();
        }
        List<ArticleEntity> sortedArticles(List<ArticleEntity> list) {
          list.sort((a, b) => b.id.compareTo(a.id));

          return list.toSet().toList();
        }

        List<Widget> getWidgets() {
          final List<Widget> list = [];
          int count = 0;
          while (count < 3) {
            list.add(Padding(
              padding: getHorizontalPadding(context),
              child: _Content(
                articles: sortedArticles(articles),
                tabs: tabs,
                pageType: pageType,
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
                  _getPageTitle(context, _currentType),
                  style: theme.textTheme.headline2,
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
                      items: tabs,
                      onTap: (index) =>
                          _onPageChanged(index, context, tabs[_currentIndex]),
                    ),

                    Expanded(
                      child: Swipe(
                        onSwipeRight: () {
                          if (_currentIndex != 0) {
                            _onPageChanged(
                              _currentIndex - 1,
                              context,
                              tabs[_currentIndex],
                            );
                          }
                        },
                        onSwipeLeft: () {
                          if (tabs.length - 1 != _currentIndex) {
                            _onPageChanged(
                              _currentIndex + 1,
                              context,
                              tabs[_currentIndex],
                            );
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
                                    ...getWidgets(),
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

  void _onPageChanged(int index, BuildContext context, String category) {
    BlocProvider.of<FetchNewsBloc>(context, listen: false)
        .add(FetchQaustionsEventBy(category));

    _pageController.jumpToPage(index);
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
          if (_currentIndex == 0) {
            log('_setupScrollController_setupScrollController_setupScrollController');
            BlocProvider.of<FetchNewsBloc>(context, listen: false)
                .add(const FetchQaustionsEvent());
          } else {
            log('222222_setupScrollController_setupScrollController_setupScrollController');
            BlocProvider.of<FetchNewsBloc>(context, listen: false)
                .add(FetchQaustionsEventBy(tabs[_currentIndex]));
          }
          // final isLastPage = articles.length < _page * 20;
          // log('$_page $isLastPage');
          // if (!isLastPage) {
          //   _page++;
          //   context.read<FetchNewsCubit>().loadNews();
          // }
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
      int index,
    ) {
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

      return const SizedBox();
    }

    log('================ $tabs ================================');

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
                        index,
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 78),
                    child: Wrap(
                      children: List.generate(
                        articles.length,
                        (index) {
                          return _builderItem(
                            articles,
                            tabs,
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
                return _builderItem(articles, tabs, index);
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
