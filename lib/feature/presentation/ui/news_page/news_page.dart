import 'package:cportal_flutter/common/util/keep_alive_util.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/faq/widgets/faq_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:swipe/swipe.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'widgets/scrollable_tabs_widget.dart';

class NewsPage extends StatefulWidget {
  final NewsCodeEnum pageType;

  const NewsPage({Key? key, required this.pageType}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final PageController _pageController = PageController();
  late int _currentIndex = 0;
  late NewsCodeEnum _currentType;

  @override
  void initState() {
    super.initState();
    _currentType = widget.pageType;
    _contentInit(_currentType);
  }

  // Во время инициализации запускается эвент и подгружается контент в зависимости от типа страницы
  void _contentInit(NewsCodeEnum type) {
    return BlocProvider.of<FetchNewsBloc>(context, listen: false)
        .add(FetchNewsEventImpl(newsCodeEnum: type));
  }

  @override
  Widget build(BuildContext context) {
    // Для обновления стейта при смене страницы в BottomBar
    if (widget.pageType != _currentType) {
      _currentType = widget.pageType;
      _contentInit(_currentType);
      _currentIndex = 0;
    }
    final double width = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: getHorizontalPadding(context),
                child: Text(
                  _getPageTitle(_currentType),
                  style: theme.textTheme.headline2,
                ),
              ),
              const SizedBox(height: 16),
              if (state is FetchNewsLoadingState) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ],
              if (state is FetchNewsLoadedState)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Категории
                    ScrollableTabsWidget(
                      currentIndex: _currentIndex,
                      items: state.tabs,
                      onTap: (index) => _onPageChanged(index),
                    ),

                    Swipe(
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
                        constraint: widget.pageType == NewsCodeEnum.quastion
                            ? const BoxConstraints(maxWidth: 720)
                            : null,
                        child: SizedBox(
                          width: width,
                          height: !ResponsiveWrapper.of(context)
                                  .isLargerThan(TABLET)
                              ? MediaQuery.of(context).size.height - 181
                              : MediaQuery.of(context).size.height - 116,
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              // Генерация страниц под все категории

                              ...List.generate(state.tabs.length, (index) {
                                return KeepAlivePage(
                                  child: Padding(
                                    padding: getHorizontalPadding(context),
                                    child: widget.pageType == NewsCodeEnum.news
                                        ? !ResponsiveWrapper.of(context)
                                                .isLargerThan(TABLET)
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 20),

                                                  // Контент
                                                  _content(state, width),
                                                ],
                                              )
                                            : SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 20),

                                                    // Контент
                                                    _content(state, width),
                                                  ],
                                                ),
                                              )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 20),

                                              // Контент
                                              _content(state, width),
                                            ],
                                          ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  // Отрисовка контента по типу страницы
  Widget _content(FetchNewsLoadedState state, double width) {
    List<ArticleEntity> articles = state.news.article;

    return widget.pageType == NewsCodeEnum.news
        ? !ResponsiveWrapper.of(context).isLargerThan(TABLET)
            ? Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return _builderItem(state, width, index);
                  },
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 78.0),
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
              )
        : Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return _builderItem(state, width, index);
              },
            ),
          );
  }

  Widget _builderItem(
    FetchNewsLoadedState state,
    double width,
    int index,
  ) {
    List<ArticleEntity> articles = state.news.article;

    if (widget.pageType == NewsCodeEnum.news) {
      // Распределение по категориям
      // [Новости]
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
    } else if (widget.pageType == NewsCodeEnum.quastion) {
      // Распределение по категориям
      // [Вопросы]
      if (articles[index].category == state.tabs[_currentIndex]) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
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

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(_currentIndex);
  }

  void _onArticleSelected(String id) {
    GoRouter.of(context).pushNamed(
      NavigationRouteNames.newsArticlePage,
      params: {'fid': id},
    );
  }

  String _getPageTitle(NewsCodeEnum pageType) {
    return pageType == NewsCodeEnum.quastion
        ? AppLocalizations.of(context)!.questions
        : AppLocalizations.of(context)!.news;
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
    final DateFormat outputFormat = DateFormat('d MMMM y, H:m', 'ru');

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: NewsCardItem(
          width: width,
          height: 160,
          fontSize: 17,
          imgPath: item.image,
          title: item.header,
          dateTime: outputFormat.format(item.dateShow),
        ),
      ),
    );
  }
}
