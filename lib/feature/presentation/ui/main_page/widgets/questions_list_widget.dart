import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/question_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class QuestionsListWidget extends StatelessWidget {
  const QuestionsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FetchQuestionsBloc>(context, listen: false)
        .add(const FetchQaustionsEvent());
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
              if (state is QuestionsLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(
                    child: PlatformProgressIndicator(),
                  ),
                );
              }

              if (state is QuestionsLoaded) {
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: QuestionRow(
                        text: state.articles[i].header,
                        onTap: () {
                          context.goNamed(
                            NavigationRouteNames.questionArticlePage,
                            params: {'fid': state.articles[i].id},
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
