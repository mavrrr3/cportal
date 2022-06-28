// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/quastions_page/widgets/quastions_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:swipe/swipe.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/scrollable_tabs_widget.dart';

class QuastionsPage extends StatefulWidget {
  const QuastionsPage({Key? key}) : super(key: key);

  @override
  State<QuastionsPage> createState() => _QuastionsPageState();
}

class _QuastionsPageState extends State<QuastionsPage> {
  late PageController pageController;
  int currentIndex = 0;

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
    BlocProvider.of<FetchNewsBloc>(context, listen: false).add(
      const FetchQaustionsEvent(),
    );

    final double width = MediaQuery.of(context).size.width;

    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        List<ArticleEntity> articles = [];
        List<ArticleEntity> currentTabArticles = [];

        List<String> categories = [];

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
          categories = state.tabs;
        } else if (state is QaustionsLoaded) {
          articles = state.articles;
          categories = state.tabs;
        }
        if (currentIndex == 0) currentTabArticles = articles;
        if (currentIndex != 0) {
          currentTabArticles = articles
              .where((element) => element.category == categories[currentIndex])
              .toList();
        }
        log('_currentIndex: $currentIndex');
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
              child: QuastionsContent(
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
                  AppLocalizations.of(context)!.questions,
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
                          _onPageChanged(index, context, categories[index]),
                    ),

                    Expanded(
                      child: Swipe(
                        onSwipeRight: () {
                          _onPageChanged(
                            currentIndex - 1,
                            context,
                            categories[currentIndex],
                          );
                        },
                        onSwipeLeft: () {
                          _onPageChanged(
                            currentIndex + 1,
                            context,
                            categories[currentIndex],
                          );
                        },
                        child: ResponsiveConstraints(
                          constraint: const BoxConstraints(maxWidth: 720),
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
    log('category $category');

    currentIndex = index;
    if (currentIndex == 0) {
      log('onPageChangedonPageChangedonPageChangedonPageChangedonPageChangedonPageChangedonPageChangedonPageChanged');
      context.read<FetchNewsBloc>().add(const FetchQaustionsEvent());
    } else {
      context.read<FetchNewsBloc>().add(FetchQaustionsEventBy(category));
    }

    pageController.jumpToPage(index);
  }
}
