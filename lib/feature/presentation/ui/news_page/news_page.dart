// ignore_for_file: unused_local_variable
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_content.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:swipe/swipe.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/news_code_enum.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/scrollable_tabs_widget.dart';

class NewsPage extends StatelessWidget {
  final NewsCodeEnum pageType;
  final PageController pageController = PageController();
  NewsPage({Key? key, required this.pageType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    void _onPageChanged(
      int index,
      BuildContext context,
      List<String> categories,
    ) {
      currentIndex = index;
      if (index == 0) {
        context.read<FetchNewsBloc>().add(const FetchAllNewsEvent());
      } else {
        context.read<FetchNewsBloc>().add(FetchNewsEventBy(categories[index]));
      }
      pageController.jumpToPage(index);
    }

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
        if (currentIndex == 0) currentTabArticles = articles;
        if (currentIndex != 0) {
          currentTabArticles = articles
              .where((element) => element.category == categories[currentIndex])
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
              child: NewsContent(
                articles: sortedArticles(articles),
                tabs: categories,
                currentIndex: currentIndex,
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
                      currentIndex: currentIndex,
                      items: categories,
                      onTap: (index) =>
                          _onPageChanged(index, context, categories),
                    ),

                    Expanded(
                      child: Swipe(
                        onSwipeRight: () {
                          if (currentIndex != 0) {
                            _onPageChanged(
                              currentIndex - 1,
                              context,
                              categories,
                            );
                          }
                        },
                        onSwipeLeft: () {
                          if (categories.length - 1 != currentIndex) {
                            _onPageChanged(
                              currentIndex + 1,
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
}
