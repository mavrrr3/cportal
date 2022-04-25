import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_horizontal_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import 'package:swipe/swipe.dart';

class NewsArticlePage extends StatelessWidget {
  const NewsArticlePage({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final DateFormat outputFormat = DateFormat('d MMMM y, H:m', 'ru');

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        if (state is FetchNewsLoadedState) {
          return Swipe(
            onSwipeRight: () => _onBack(context),
            child: Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: theme.backgroundColor,
                      expandedHeight: 176.h,
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        enableFeedback: false,
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 24.w,
                        onPressed: () => _onBack(context),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          state.news.article[currentIndex].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    /// Колонка с контентом статьи
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0.h,
                          horizontal: 20.0.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.news.article[currentIndex].header,
                              style: theme.textTheme.headline3,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              outputFormat.format(
                                state.news.article[currentIndex].dateShow,
                              ),
                              style: theme.textTheme.bodyText1,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              state.news.article[currentIndex].description,
                              style: theme.textTheme.headline6,
                            ),
                            SizedBox(height: 20.h),
                            NewsHorizontalScroll(
                              items: state.news.article,
                              isTextVisible: false,
                              currentArticle: state.news.article[currentIndex],
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
          );
        }

        /// TODO: Отработать другие стейты
        return const SizedBox();
      },
    );
  }

  void _onBack(BuildContext context) => GoRouter.of(context).pop();
}
