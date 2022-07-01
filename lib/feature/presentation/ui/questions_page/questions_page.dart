// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/questions_content.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:swipe/swipe.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/scrollable_tabs_widget.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
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
    BlocProvider.of<FetchQuestionsBloc>(context, listen: false).add(
      const FetchQaustionsEvent(),
    );

    final double width = MediaQuery.of(context).size.width;

    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<FetchQuestionsBloc, FetchQuestionsState>(
      builder: (context, state) {
        List<ArticleEntity> articles = [];
        List<ArticleEntity> currentTabArticles = [];

        List<String> categories = [];

        if (state is QuestionsLoading && state.isFirstFetch) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Center(
              child: PlatformProgressIndicator(),
            ),
          );
        } else if (state is QuestionsLoading) {
          articles = state.oldArticles;
          categories = state.tabs;
        } else if (state is QuestionsLoaded) {
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
              child: QuestionsContent(
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
                          onPageChanged(index, context, categories),
                    ),

                    Expanded(
                      child: Swipe(
                        onSwipeRight: () {
                          onPageChanged(
                            currentIndex - 1,
                            context,
                            categories,
                          );
                        },
                        onSwipeLeft: () {
                          onPageChanged(
                            currentIndex + 1,
                            context,
                            categories,
                          );
                        },
                        child: ResponsiveConstraints(
                          constraint: const BoxConstraints(maxWidth: 1046),
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

  void onPageChanged(
    int index,
    BuildContext context,
    List<String> categories,
  ) {
    log('category $categories');

    currentIndex = index;
    if (index == 0) {
      context.read<FetchQuestionsBloc>().add(const FetchQaustionsEvent());
    } else {
      context
          .read<FetchQuestionsBloc>()
          .add(FetchQaustionsEventBy(categories[index]));
    }

    pageController.jumpToPage(index);
  }
}
