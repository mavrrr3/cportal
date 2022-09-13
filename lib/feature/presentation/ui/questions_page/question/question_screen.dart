import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/question/widgets/question_content.dart';

import 'package:cportal_flutter/feature/presentation/ui/questions_page/question/widgets/question_layout.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/loader.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/burger_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/menu_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class QuestionScreen extends StatelessWidget {
  final String id;

  const QuestionScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchQuestionsBloc, FetchQuestionsState>(
      builder: (context, state) {
        List<ArticleEntity> articles = [];
        ArticleEntity? question;

        if (state is QuestionsLoading) {
          articles = state.oldArticles;
          question = _getQuestion(state.oldArticles);
        } else if (state is QuestionsLoaded) {
          question = _getQuestion(state.articles);
          articles = state.articles;
        }

        return Stack(
          children: [
            QuestionLayout(
              child: question != null
                  ? QuestionContent(
                      question: question,
                      questions: articles,
                    )
                  : BlocBuilder<GetSingleQuestionBloc, GetSingleQuestionState>(
                      builder: (context, state) {
                        if (state is GetSingleQuestionLoadedState) {
                          return QuestionContent(question: state.singleQuestion);
                        }

                        return const Loader();
                      },
                    ),
            ),
            BurgerMenu(
              currentIndex: 2,
              onChange: (i) => MenuService.changePage(context, i),
            ),
          ],
        );
      },
    );
  }

  ArticleEntity? _getQuestion(List<ArticleEntity> questions) =>
      questions.where((element) => element.id == id).firstOrNull;
}
