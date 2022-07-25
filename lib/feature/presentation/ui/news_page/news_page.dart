// ignore_for_file: unused_local_variable
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:swipe/swipe.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/scrollable_tabs_widget.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    void onPageChanged(
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

    final double width = MediaQuery.of(context).size.width;
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        List<ArticleEntity> articles = [];
        List<ArticleEntity> currentTabArticles = [];

        List<String> categories = [];

        if (state is NewsLoading) {
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
                          onPageChanged(index, context, categories),
                    ),

                    Expanded(
                      child: Swipe(
                        onSwipeRight: () {
                          if (currentIndex != 0) {
                            onPageChanged(
                              currentIndex - 1,
                              context,
                              categories,
                            );
                          }
                        },
                        onSwipeLeft: () {
                          if (categories.length - 1 != currentIndex) {
                            onPageChanged(
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
                                children: getWidgets(),
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
