import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_horizontal_scroll.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:swipe/swipe.dart';

final DateFormat _outputFormat = DateFormat('d MMMM y, H:m', 'ru');

class NewsArticlePage extends StatelessWidget {
  const NewsArticlePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        dynamic id = GoRouter.of(context).location.split('/');
        id = id[2] as String;
        final ArticleEntity _currentItem;
        // ignore: prefer-conditional-expressions
        if (state is FetchNewsLoadedState) {
          _currentItem = state.news.article.firstWhere(
            (element) => element.id == id,
          );
          
        } else {
          //: TODO отработать другие стейты
          _currentItem = ArticleEntity(
            id: '000',
            articleType: const ArticleTypeEntity(
              id: '000',
              code: '000',
              description: 'qqq',
            ),
            header: 'Emty state Header',
            category: '',
            description: '',
            image: '',
            dateShow: DateTime.now(),
            externalLink: '',
            show: true,
            userCreated: '',
            dateCreated: DateTime.now(),
            userUpdate: '',
            dateUpdated: DateTime.now(),
          );
        }
        if (state is FetchNewsLoadedState) {
          return BlocBuilder<NavBarBloc, NavBarState>(
            builder: (context, navState) {
              return Swipe(
                onSwipeRight: () => _onBack(context),
                child: Scaffold(
                  body: !ResponsiveWrapper.of(context).isLargerThan(TABLET)
                      ? _Mobile(
                          item: _currentItem,
                          navState: navState,
                          state: state,
                        )
                      : _Web(
                          item: _currentItem,
                          navState: navState,
                          state: state,
                        ),
                ),
              );
            },
          );
        }

        /// TODO: Отработать другие стейты
        return const SizedBox();
      },
    );
  }
}

class _Mobile extends StatelessWidget {
  const _Mobile({
    Key? key,
    required this.item,
    required this.navState,
    required this.state,
  }) : super(key: key);
  final ArticleEntity item;
  final FetchNewsLoadedState state;
  final NavBarState navState;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: ResponsiveConstraints(
        constraint: const BoxConstraints(maxWidth: 640),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: theme.backgroundColor,
              expandedHeight: 176,
              automaticallyImplyLeading: false,
              leading: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                enableFeedback: false,
                icon: const Icon(Icons.arrow_back),
                iconSize: 24,
                onPressed: () => _onBack(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: ExtendedImage.network(
                  item.image,
                  fit: BoxFit.cover,
                  cache: true,
                ),
              ),
            ),

            /// Колонка с контентом статьи
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.header,
                      style: theme.textTheme.headline3,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _outputFormat.format(
                        item.dateShow,
                      ),
                      style: theme.textTheme.bodyText1,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      item.description,
                      style: theme.textTheme.headline6,
                    ),
                    const SizedBox(height: 20),
                    NewsHorizontalScroll(
                      items: state.news.article,
                      isTextVisible: false,
                      currentArticle: item,
                      onTap: (index) {
                        GoRouter.of(context).pop();
                        GoRouter.of(context).pushNamed(
                          NavigationRouteNames.newsArticlePage,
                          extra: index,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Web extends StatelessWidget {
  const _Web({
    Key? key,
    required this.item,
    required this.navState,
    required this.state,
  }) : super(key: key);
  final ArticleEntity item;
  final FetchNewsLoadedState state;

  final NavBarState navState;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DesktopMenu(
          currentIndex: navState.currentIndex,
          onChange: (index) {
            BlocProvider.of<NavBarBloc>(context)
                .add(NavBarEventImpl(index: index));
            GoRouter.of(context).goNamed(NavigationRouteNames.mainPage);
          },
          items: navState.menuItems,
        ),
        SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ResponsiveConstraints(
              constraint: const BoxConstraints(maxWidth: 704),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        GoRouter.of(context).pop();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/back_arrow.svg',
                            width: 16,
                            color: theme.primaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppLocalizations.of(context)!.news,
                            style: theme.textTheme.headline5!.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 310,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                item.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            item.header,
                            style: theme.textTheme.headline3,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _outputFormat.format(
                              item.dateShow,
                            ),
                            style: theme.textTheme.bodyText1,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            item.description,
                            style: theme.textTheme.headline6,
                          ),
                          const SizedBox(height: 40),
                          _recomendations(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _recomendations() {
    List<ArticleEntity> recomendationsList = state.news.article;
    recomendationsList.removeWhere((element) => element == item);

    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: List.generate(recomendationsList.length, (i) {
        return NewsCardItem(
          width: 312,
          height: 152,
          imgPath: recomendationsList[i].image,
          title: recomendationsList[i].header,
          dateTime: _outputFormat.format(
            recomendationsList[i].dateShow,
          ),
        );
      }),
    );
  }
}

void _onBack(BuildContext context) => GoRouter.of(context).pop();
