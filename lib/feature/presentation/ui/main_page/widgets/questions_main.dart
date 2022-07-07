import 'dart:developer';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/question_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuestionsMain extends StatelessWidget {
  final ScrollController questionController;
  const QuestionsMain({Key? key, required this.questionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: getHorizontalPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.faq,
            style: theme.textTheme.px22,
          ),
          const SizedBox(height: 16),
          BlocBuilder<FetchQuestionsBloc, FetchQuestionsState>(
            builder: (context, state) {
              List<ArticleEntity> articles;

              if (state is QuestionsLoading && state.isFirstFetch) {
                return const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 60,
                  ),
                  child: Center(
                    child: PlatformProgressIndicator(),
                  ),
                );
              } else if (state is QuestionsLoading) {
                articles = state.oldArticles;
                log(articles.toString());
              } else if (state is QuestionsLoaded) {
                final articles = state.articles;

                return ListView.builder(
                  controller: questionController,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: AppConfig.numberNewsArticlesOnMain,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 24,
                      ),
                      child: QuestionRow(
                        text: articles[i].header,
                        onTap: () {
                          context.pushNamed(
                            NavigationRouteNames.questionArticlePage,
                            params: {
                              'fid': articles[i].id,
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
