import 'dart:developer';

import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_horizontal_scroll.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        if (state is FetchNewsLoadedState) {
          return BlocBuilder<NavBarBloc, NavBarState>(
            builder: (context, navState) {
              return Swipe(
                onSwipeRight: () => _onBack(context),
                child: Scaffold(
                  body: !ResponsiveWrapper.of(context).isLargerThan(TABLET)
                      ? _Mobile(
                          state: state,
                          navState: navState,
                        )
                      : _Web(
                          state: state,
                          navState: navState,
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
    required this.state,
    required this.navState,
  }) : super(key: key);
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
                  state.news.article[state.openedIndex!].image,
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
                      state.news.article[state.openedIndex!].header,
                      style: theme.textTheme.headline3,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _outputFormat.format(
                        state.news.article[state.openedIndex!].dateShow,
                      ),
                      style: theme.textTheme.bodyText1,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.news.article[state.openedIndex!].description,
                      style: theme.textTheme.headline6,
                    ),
                    const SizedBox(height: 20),
                    NewsHorizontalScroll(
                      items: state.news.article,
                      isTextVisible: false,
                      currentArticle: state.news.article[state.openedIndex!],
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
    required this.state,
    required this.navState,
  }) : super(key: key);
  final FetchNewsLoadedState state;
  final NavBarState navState;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    log('[Opened Index] ${state.openedIndex}');

    return Row(mainAxisSize: MainAxisSize.min, children: [
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
                    state.news.article[state.openedIndex!].image,
                    fit: BoxFit.cover,
                    cache: true,
                  ),
                ),
              ),
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
                        state.news.article[state.openedIndex!].header,
                        style: theme.textTheme.headline3,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _outputFormat.format(
                          state.news.article[state.openedIndex!].dateShow,
                        ),
                        style: theme.textTheme.bodyText1,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        state.news.article[state.openedIndex!].description,
                        style: theme.textTheme.headline6,
                      ),
                      const SizedBox(height: 20),
                      NewsHorizontalScroll(
                        items: state.news.article,
                        isTextVisible: false,
                        currentArticle: state.news.article[state.openedIndex!],
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
      ),
    ]);
  }
}

void _onBack(BuildContext context) => GoRouter.of(context).pop();
