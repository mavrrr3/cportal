import 'dart:developer';

import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

int _currentIndex = 0;

void _contentInit(BuildContext context) {
  return BlocProvider.of<FetchNewsBloc>(context, listen: false)
      .add(const FetchNewsEventImpl(newsCodeEnum: NewsCodeEnum.news));
}

class NewsPageWeb extends StatefulWidget {
  const NewsPageWeb({Key? key}) : super(key: key);

  @override
  State<NewsPageWeb> createState() => _NewsPageWebState();
}

class _NewsPageWebState extends State<NewsPageWeb> {
  @override
  void initState() {
    super.initState();
    _contentInit(context);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    _contentInit(context);

    void _onPageChanged(int index) {
      setState(() {
        _currentIndex = index;
        _contentInit(context);
      });
      log(_currentIndex.toString());
    }

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              child: TabBarWidget(
                title: AppLocalizations.of(context)!.news,
                categoryTitle: [
                  if (state is FetchNewsLoadedState) ...state.tabs
                ],
                currentIndex: _currentIndex,
                onTap: (index) => _onPageChanged(index),
              ),
              preferredSize: Size(width, 114)),
          body: Padding(
              padding: getHorizontalPadding(context),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    if (state is FetchNewsLoadedState)
                      _ContentPage(blocState: state),
                  ],
                ),
              )),
        );
      },
    );
  }
}

class _ContentPage extends StatelessWidget {
  final FetchNewsLoadedState blocState;
  const _ContentPage({
    Key? key,
    required this.blocState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ArticleEntity> articles = blocState.news.article;
    final double width = MediaQuery.of(context).size.width;

    void _onArticleSelected(String id) {
      GoRouter.of(context).pushNamed(
        NavigationRouteNames.newsArticlePage,
        params: {'fid': id},
      );
    }

    Widget _builderItem(
      FetchNewsLoadedState state,
      double width,
      int index,
    ) {
      List<ArticleEntity> articles = state.news.article;

      Widget _newsCard() {
        return _NewsCard(
          width,
          item: articles[index],
          onTap: () => _onArticleSelected(articles[index].id),
        );
      }

      if (_currentIndex == 0) {
        return _newsCard();
      } else if (articles[index].category == state.tabs[_currentIndex]) {
        return _newsCard();
      }
      return const SizedBox();
    }

    return ResponsiveWrapper.of(context).isSmallerThan(TABLET)
        ? Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return _builderItem(blocState, width, index);
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
                  return _builderItem(blocState, 312, index);
                },
              ),
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

class TabBarWidget extends StatefulWidget {
  final String title;
  final List<String> categoryTitle;
  final int currentIndex;
  final Function(int) onTap;
  const TabBarWidget({
    Key? key,
    required this.title,
    required this.categoryTitle,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: getHorizontalPadding(context),
          child: Text(
            widget.title,
            style: theme.textTheme.headline2,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: getHorizontalPadding(context),
          child: SizedBox(
            width: width,
            height: 30.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.categoryTitle.length,
              itemBuilder: (context, index) {
                return _textButton(
                  theme,
                  text: widget.categoryTitle[index],
                  onTap: () {
                    widget.onTap(index);
                  },
                  isCurrent: widget.currentIndex == index,
                );
              },
            ),
          ),
        ),
        Container(
          height: 1,
          color: theme.dividerColor,
        ),
      ],
    );
  }

  Widget _textButton(
    ThemeData theme, {
    required String text,
    required bool isCurrent,
    Function()? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          right: !ResponsiveWrapper.of(context).isLargerThan(TABLET) ? 8.0 : 19,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeIn,
          decoration: BoxDecoration(
            border: isCurrent
                ? Border(
                    bottom: BorderSide(
                      width: 2.5,
                      color: theme.primaryColor,
                    ),
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              text,
              style: isCurrent
                  ? theme.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.primaryColor,
                    )
                  : theme.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

SliverAppBar _appBar() {
  return SliverAppBar(
    onStretchTrigger: () => Future(() => debugPrint('qwee')),
    automaticallyImplyLeading: false,
    expandedHeight: 205,
    bottom: const TabBar(
      indicator: BoxDecoration(
        color: AppColors.appBarLight,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      labelStyle: TextStyle(fontSize: 14),
      indicatorColor: Colors.transparent,
      indicatorWeight: 3.0,
      tabs: [
        Tab(child: Text('Все заказы')),
        Tab(child: Text('Принятые')),
        Tab(child: Text('История')),
      ],
    ),
  );
}
