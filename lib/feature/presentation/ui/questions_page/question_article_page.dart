import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_template.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/question_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
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

    return Swipe(
      onSwipeRight: () {
        if (!kIsWeb) {
          onBack(context);
        }
      },
      child: BlocBuilder<FetchQuestionsBloc, FetchQuestionsState>(
        builder: (context, state) {
          if (state is QuestionsLoaded) {
            final ArticleEntity singleArticle = state.singleArticle(id);

            return BlocBuilder<NavigationBarBloc, NavigationBarState>(
              builder: (context, navState) {
                return Scaffold(
                  backgroundColor: theme.background,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ResponsiveVisibility(
                            visible: false,
                            visibleWhen: const [
                              Condition<dynamic>.largerThan(name: TABLET),
                            ],
                            child: DesktopMenu(
                              currentIndex: 2,
                              onChange: (index) => changePage(context, index),
                            ),
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
                                            AppLocalizations.of(context)!
                                                .questions,
                                            style:
                                                theme.textTheme.px16.copyWith(
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
                                    horizontal:
                                        isLargerThenTablet(context) ? 32 : 20.0,
                                  ),
                                  child: ResponsiveConstraints(
                                    constraint: isLargerThenTablet(context)
                                        ? const BoxConstraints(maxWidth: 1046)
                                        : null,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: isLargerThenTablet(context)
                                              ? 4
                                              : 19,
                                        ),
                                        // Кнопка назад mobile.
                                        if (isLargerThenTablet(context))
                                          const SizedBox()
                                        else
                                          GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            onTap: () => onBack(context),
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              singleArticle.header,
                                              style: theme.textTheme.header,
                                            ),
                                            const SizedBox(height: 20),
                                            Column(
                                              children: [
                                                ...List.generate(
                                                  singleArticle.content.length,
                                                  (index) {
                                                    return NewsTemplate.factory(
                                                      context,
                                                      singleArticle
                                                          .content[index],
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 24),
                                            nextQuestion(
                                              singleArticle,
                                              state,
                                              context,
                                            ),
                                          ],
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
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget nextQuestion(
    ArticleEntity currentItem,
    QuestionsLoaded state,
    BuildContext context,
  ) {
    final List<ArticleEntity> currentTabsItems = [];
    for (final item in state.articles) {
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

  void onBack(BuildContext context) => context.pop();
}
