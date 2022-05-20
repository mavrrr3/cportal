import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/faq/widgets/faq_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:swipe/swipe.dart';

class QuestionArticlePage extends StatelessWidget {
  const QuestionArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Swipe(
      onSwipeRight: () => _onBack(context),
      child: BlocBuilder<FetchNewsBloc, FetchNewsState>(
        builder: (context, state) {
          dynamic id = GoRouter.of(context).location.split('/');
          id = id[2] as String;
          final ArticleEntity currentItem;
          // ignore: prefer-conditional-expressions
          if (state is FetchNewsLoadedState) {
            currentItem = state.news.article.firstWhere(
              (element) => element.id == id,
            );
          } else {
            //: TODO отработать другие стейты
            currentItem = ArticleEntity(
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

          return BlocBuilder<NavBarBloc, NavBarState>(
            builder: (context, navState) {
              return Scaffold(
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
                              // Кнопка назад для Web
                              ResponsiveWrapper.of(context).isLargerThan(TABLET)
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                        left: 7.0,
                                        top: 16.0,
                                      ),
                                      child: GestureDetector(
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
                                              AppLocalizations.of(context)!
                                                  .questions,
                                              style: theme.textTheme.headline5!
                                                  .copyWith(
                                                color: theme.primaryColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveWrapper.of(context)
                                          .isLargerThan(TABLET)
                                      ? 32
                                      : 20.0,
                                ),
                                child: ResponsiveConstraints(
                                  constraint: ResponsiveWrapper.of(context)
                                          .isLargerThan(TABLET)
                                      ? const BoxConstraints(maxWidth: 640)
                                      : null,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: ResponsiveWrapper.of(context)
                                                .isLargerThan(TABLET)
                                            ? 4
                                            : 19,
                                      ),
                                      // Кнопка назад mobile
                                      !ResponsiveWrapper.of(context)
                                              .isLargerThan(TABLET)
                                          ? GestureDetector(
                                              behavior:
                                                  HitTestBehavior.translucent,
                                              onTap: () => _onBack(context),
                                              child: Stack(
                                                children: [
                                                  const SizedBox(
                                                    width: 26,
                                                    height: 24,
                                                  ),
                                                  SvgPicture.asset(
                                                    'assets/icons/back_arrow.svg',
                                                    width: 16,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const SizedBox(),
                                      !ResponsiveWrapper.of(context)
                                              .isLargerThan(TABLET)
                                          ? const SizedBox(height: 19)
                                          : const SizedBox(),
                                      if (state is FetchNewsLoadedState)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              currentItem.header,
                                              style: theme.textTheme.headline1,
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              currentItem.description,
                                              style: theme.textTheme.headline5,
                                            ),
                                            const SizedBox(height: 24),
                                            _nextQuestion(
                                              currentItem,
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
        },
      ),
    );
  }

  Widget _nextQuestion(
    ArticleEntity currentItem,
    FetchNewsLoadedState state,
    BuildContext context,
  ) {
    List<ArticleEntity> currentTabsItems = [];
    for (var item in state.news.article) {
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
            padding: const EdgeInsets.only(bottom: 32.0),
            child: FaqRow(
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

  void _onBack(BuildContext context) => GoRouter.of(context).pop();
}
