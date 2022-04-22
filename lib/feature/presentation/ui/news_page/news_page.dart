import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/common/util/keep_alive_util.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:swipe/swipe.dart';

import '../main_page/widgets/news_card_item.dart';
import 'widgets/scrollable_tabs_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key, required this.pageType}) : super(key: key);
  final NewsCodeEnum pageType;
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late int _currentIndex;
  late PageController _pageController;
  late NewsCodeEnum _currentPage;
  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pageController = PageController();
    _currentPage = widget.pageType;
    _contentInit();
  }

  void _contentInit() {
    // Во время инициализации запускается эвент и подгружается контент в зависимости от типа страницы
    switch (widget.pageType) {
      case NewsCodeEnum.news:
        BlocProvider.of<FetchNewsBloc>(context, listen: false)
            .add(const FetchNewsEventImpl(newsCodeEnum: NewsCodeEnum.news));
        break;
      case NewsCodeEnum.quastion:
        BlocProvider.of<FetchNewsBloc>(context, listen: false)
            .add(const FetchNewsEventImpl(newsCodeEnum: NewsCodeEnum.quastion));
        break;
      default:
        BlocProvider.of<FetchNewsBloc>(context, listen: false)
            .add(const FetchNewsEventImpl(newsCodeEnum: NewsCodeEnum.news));
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Для обновления стейта при смене страницы в BottomBar
    if (widget.pageType != _currentPage) {
      _contentInit();
      _currentPage = widget.pageType;
      _currentIndex = 0;
    }
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Text(
                  _getPageTitle,
                  style: kMainTextRusso.copyWith(
                    fontSize: 28.sp,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              if (state is FetchNewsLoadingState) ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.0.h),
                  child: const Center(
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
                    /// Категории
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
                      child: SizedBox(
                        width: width,
                        height: MediaQuery.of(context).size.height - 181.h,
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ///Генерация страниц под все категории
                            ...List.generate(state.tabs.length, (index) {
                              return KeepAlivePage(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0.w),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20.h),

                                      /// Контент
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
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  /// Отрисовка контента по типу страницы
  Widget _content(FetchNewsLoadedState state, double width) {
    /// [Новости]
    if (widget.pageType == NewsCodeEnum.news) {
      return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: state.news.article.length,
          itemBuilder: (context, index) {
            /// Распределение по категориям
            if (_currentIndex == 0) {
              return _newsCard(
                width,
                item: state.news.article[index],
                onTap: () => _onArticleSelected(state.news.article[index]),
              );
            } else if (state.news.article[index].category ==
                state.tabs[_currentIndex]) {
              return _newsCard(
                width,
                item: state.news.article[index],
                onTap: () => _onArticleSelected(state.news.article[index]),
              );
            }
            // ignore: newline-before-return
            return const SizedBox();
          },
        ),
      );

      /// [Вопросы]
    } else if (widget.pageType == NewsCodeEnum.quastion) {
      return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: state.news.article.length,
          itemBuilder: (context, index) {
            /// Распределение по категориям
            if (state.news.article[index].category ==
                state.tabs[_currentIndex]) {
              return Padding(
                padding: EdgeInsets.only(bottom: 30.0.h),
                child: QuestionWidget(
                  text: state.news.article[index].header,
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                      NavigationRouteNames.questionArticlePage,
                      extra: index,
                    );
                  },
                ),
              );
            }

            // ignore: newline-before-return
            return const SizedBox();
          },
        ),
      );
    }

    return const SizedBox();
  }

  Widget _newsCard(
    double width, {
    required ArticleEntity item,
    required Function() onTap,
  }) {
    final DateFormat outputFormat = DateFormat('d MMMM y, H:m', 'ru');

    return Padding(
      padding: EdgeInsets.only(bottom: 20.0.h),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: NewsCardItem(
          width: width,
          height: 160.h,
          fontSize: 17.sp,
          imgPath: item.image,
          title: item.header,
          dateTime: outputFormat.format(item.dateShow),
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(_currentIndex);
  }

  void _onArticleSelected(ArticleEntity item) {
    GoRouter.of(context).pushNamed(
      NavigationRouteNames.newsArticlePage,
      extra: item,
    );
  }

  String get _getPageTitle {
    switch (widget.pageType) {
      case NewsCodeEnum.news:
        return AppLocalizations.of(context)!.news;
      case NewsCodeEnum.quastion:
        return AppLocalizations.of(context)!.questions;
      default:
        return AppLocalizations.of(context)!.news;
    }
  }
}
