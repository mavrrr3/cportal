import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/faq/widgets/faq_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:swipe/swipe.dart';

// void _contentInit(BuildContext context) {
//   return BlocProvider.of<FetchNewsBloc>(context, listen: false).add(
//     const FetchNewsEvent(),
//   );
// }

class QuestionArticlePage extends StatelessWidget {
  final String id;
  const QuestionArticlePage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Swipe(
      onSwipeRight: () {
        if (!kIsWeb) {
          _onBack(context);
        }
      },
      child: BlocBuilder<FetchNewsBloc, FetchNewsState>(
        builder: (context, state) {
          if (state is NewsLoaded) {
            ArticleEntity articlefromBloc() {
              return state.articles
                  .where((element) => element.id == id)
                  .toList()
                  .first;
            }

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
                                // Кнопка назад для Web.
                                if (ResponsiveWrapper.of(context)
                                    .isLargerThan(TABLET))
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 7,
                                      top: 16,
                                    ),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        // _contentInit(context);.

                                        GoRouter.of(context).pop();
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/back_arrow.svg',
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
                                        // Кнопка назад mobile.
                                        if (!ResponsiveWrapper.of(context)
                                            .isLargerThan(TABLET))
                                          GestureDetector(
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
                                        else
                                          const SizedBox(),
                                        if (!ResponsiveWrapper.of(context)
                                            .isLargerThan(TABLET))
                                          const SizedBox(height: 19)
                                        else
                                          const SizedBox(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              articlefromBloc().header,
                                              style: theme.textTheme.header,
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              articlefromBloc()
                                                  .content
                                                  .toString(),
                                              style: theme.textTheme.px14,
                                            ),
                                            const SizedBox(height: 24),
                                            _nextQuestion(
                                              articlefromBloc(),
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

  Widget _nextQuestion(
    ArticleEntity currentItem,
    NewsLoaded state,
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
