import 'dart:developer';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/question_preview.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuestionsMain extends StatelessWidget {
  final ScrollController questionController;
  const QuestionsMain({Key? key, required this.questionController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.faq,
          style: theme.textTheme.px22,
        ),
        const SizedBox(height: 4),
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

              return ListView.separated(
                controller: questionController,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: AppConfig.numberNewsArticlesOnMain,
                itemBuilder: (context, i) {
                  return OnHover(
                    builder: (isHovered) {
                      return Opacity(
                        opacity: isHovered ? 0.6 : 1,
                        child: QuestionPreview(
                          text: articles[i].header,
                          onTap: () {
                            context.goNamed(
                              NavigationRouteNames.question,
                              params: {'fid': articles[i].id},
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
