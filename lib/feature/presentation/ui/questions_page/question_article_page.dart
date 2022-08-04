import 'dart:developer';

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_template.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/question_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:swipe/swipe.dart';

class QuestionArticlePage extends StatelessWidget {
  final String id;
  const QuestionArticlePage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    late ArticleEntity? singleArticle;

    final state = context.watch<FetchQuestionsBloc>().state;
    if (state is QuestionsLoaded) {
      singleArticle = state.singleQuestion(id);
    }

    return Swipe(
      onSwipeRight: () {
        if (!kIsWeb) {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: theme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isLargerThenTablet(context))
                  DesktopMenu(
                    currentIndex: 2,
                    onChange: (index) => MenuService.changePage(context, index),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Кнопка назад для Tablet/Web.
                      if (isLargerThenTablet(context))
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 7,
                            top: 16,
                          ),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              context.pop();
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  ImageAssets.backArrow,
                                  width: 16,
                                  color: theme.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  AppLocalizations.of(context)!.questions,
                                  style: theme.textTheme.px16.copyWith(
                                    color: theme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        const SizedBox(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isLargerThenTablet(context) ? 32 : 20.0,
                        ),
                        child: ResponsiveConstraints(
                          constraint: isLargerThenTablet(context)
                              ? const BoxConstraints(
                                  maxWidth: 1046,
                                )
                              : null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: isLargerThenTablet(context) ? 4 : 19,
                              ),
                              // Кнопка назад mobile.
                              if (isLargerThenTablet(context))
                                const SizedBox()
                              else
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () => context.pop(),
                                  child: Stack(
                                    children: [
                                      const SizedBox(
                                        width: 26,
                                        height: 24,
                                      ),
                                      SvgPicture.asset(
                                        ImageAssets.backArrow,
                                        width: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              if (isLargerThenTablet(context))
                                const SizedBox()
                              else
                                const SizedBox(height: 19),

                              if (singleArticle == null)
                                BlocBuilder<GetSingleQuestionBloc,
                                    GetSingleQuestionState>(
                                  builder: (context, state) {
                                    log(state.toString());
                                    if (state is GetSingleQuestionLoadedState) {
                                      return SingleQuestionArticle(
                                        article: state.singleQuestion,
                                      );
                                    }

                                    return const SizedBox();
                                  },
                                )
                              else
                                BlocBuilder<FetchQuestionsBloc,
                                    FetchQuestionsState>(
                                  builder: (context, state) {
                                    log(state.toString());
                                    if (state is QuestionsLoaded) {
                                      return SingleQuestionArticle(
                                        article: state.singleQuestion(id)!,
                                        articles: state.articles,
                                      );
                                    }

                                    return const SizedBox();
                                  },
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
          ),
        ),
      ),
    );
  }
}

class SingleQuestionArticle extends StatelessWidget {
  final ArticleEntity article;
  final List<ArticleEntity>? articles;
  const SingleQuestionArticle({
    Key? key,
    required this.article,
    this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.header,
          style: theme.textTheme.header,
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            ...List.generate(
              article.content.length,
              (index) {
                return NewsTemplate.factory(
                  context,
                  article.content[index],
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (articles != null)
          nextQuestion(
            article,
            articles!,
            context,
          )
        else
          const SizedBox(),
      ],
    );
  }

  Widget nextQuestion(
    ArticleEntity currentItem,
    List<ArticleEntity> articles,
    BuildContext context,
  ) {
    final List<ArticleEntity> currentTabsItems = [];
    for (final item in articles) {
      if (item.category == currentItem.category) {
        currentTabsItems.add(item);
      }
    }
    final currentIndex =
        currentTabsItems.indexWhere((element) => element.id == currentItem.id);

    return currentTabsItems.length - 1 !=
            currentTabsItems
                .indexWhere((element) => element.id == currentItem.id)
        ? Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: QuestionRow(
              text: currentTabsItems[currentIndex + 1].header,
              onTap: () {
                GoRouter.of(context).pop();
                GoRouter.of(context).pushNamed(
                  NavigationRouteNames.questionArticlePage,
                  params: {
                    'fid': currentTabsItems[currentIndex + 1].id,
                  },
                );
              },
            ),
          )
        : const SizedBox();
  }
}
