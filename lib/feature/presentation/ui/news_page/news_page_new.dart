// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:cportal_flutter/common/util/keep_alive_page.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:swipe/swipe.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/scrollable_tabs_widget.dart';

class NewsPageNew extends StatefulWidget {
  const NewsPageNew({Key? key}) : super(key: key);

  @override
  State<NewsPageNew> createState() => _NewsPageNewState();
}

class _NewsPageNewState extends State<NewsPageNew> {
  final scrollController = ScrollController();

  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    // _contentInit();
    _currentIndex = 0;
  }

  // Во время инициализации запускается эвент и подгружается контент в зависимости от типа страницы.
  void _contentInit() {
    BlocProvider.of<FetchNewsBloc>(context, listen: false)
        .add(const FetchNewsEvent());
  }

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // BlocProvider.of<FetchNewsBloc>(context, listen: false)
        //     .add(const FetchNewsEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log('++++++++++++++++++++ NewsPageNew build ++++++++++++++++');
    setupScrollController(context);
    // Для обновления стейта при смене страницы в BottomBar.

    final double width = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        NewsEntity news = NewsEntity(
          response: ResponseEntity(
            count: 0,
            update: 0,
            categories: null,
            articles: [],
          ),
        );

        if (state is FetchNewsLoadingState) news = state.oldNews;
        if (state is FetchNewsLoadedState) news = state.news;

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: getHorizontalPadding(context),
                child: Text(
                  'Новости',
                  style: theme.textTheme.headline2,
                ),
              ),
              const SizedBox(height: 16),
              if (state is FetchNewsLoadingState && state.isFirstFetch) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ],
              if (state is FetchNewsLoadedState)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Категории.
                      ScrollableTabsWidget(
                        currentIndex: _currentIndex,
                        items: state.tabs,
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
                            if (state.tabs.length - 1 != _currentIndex) {
                              _onPageChanged(_currentIndex + 1);
                            }
                          },
                          child: ResponsiveConstraints(
                            child: Column(
                              children: [
                                Expanded(
                                  child: PageView(
                                    controller: _pageController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      // Генерация страниц под все категории.

                                      ...List.generate(
                                        state.tabs.length,
                                        (index) {
                                          return KeepAlivePage(
                                            child: Padding(
                                              padding:
                                                  getHorizontalPadding(context),
                                              child: !ResponsiveWrapper.of(
                                                context,
                                              ).isLargerThan(TABLET)
                                                  ? _content(state, width)
                                                  : SingleChildScrollView(
                                                      child: _content(
                                                        state,
                                                        width,
                                                      ),
                                                    ),
                                            ),
                                          );
                                        },
                                      ),
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

  // Отрисовка контента по типу страницы.
  Widget _content(FetchNewsLoadedState state, double width) {
    final List<ArticleEntity> articles = state.news.response.articles;
    log('===================== ${state.tabs} ===========================');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // Контент.
        if (!ResponsiveWrapper.of(context).isLargerThan(TABLET))
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return _builderItem(state, width, index);
              },
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(right: 78),
            child: Wrap(
              spacing: 16,
              runSpacing: 20,
              children: List.generate(
                articles.length,
                (index) {
                  return _builderItem(state, 312, index);
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _builderItem(
    FetchNewsLoadedState state,
    double width,
    int index,
  ) {
    final List<ArticleEntity> articles = state.news.response.articles;

    if (_currentIndex == 0) {
      return _NewsCard(
        width,
        item: articles[index],
        onTap: () => _onArticleSelected(articles[index].id),
      );
    } else if (articles[index].category == state.tabs[_currentIndex]) {
      return _NewsCard(
        width,
        item: articles[index],
        onTap: () => _onArticleSelected(articles[index].id),
      );
    }

    return const SizedBox();
  }

  void _onPageChanged(int index) {
    _currentIndex = index;
    _contentInit();

    _pageController.jumpToPage(_currentIndex);
  }

  void _onArticleSelected(String id) {
    GoRouter.of(context).pushNamed(
      NavigationRouteNames.newsArticlePage,
      params: {'fid': id},
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
