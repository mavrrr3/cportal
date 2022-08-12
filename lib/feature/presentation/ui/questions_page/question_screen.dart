import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_question_bloc/get_single_question_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/question_content.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/layout_with_app_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class QuestionScreen extends StatefulWidget {
  final String id;

  const QuestionScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ArticleEntity? question;

    final state = context.read<FetchQuestionsBloc>().state;
    if (state is QuestionsLoaded) {
      question = _getQuestion(state.articles);
    } else if (state is QuestionsLoading) {
      question = _getQuestion(state.oldArticles);
    }

    return LayoutWithAppBar(
      title: '',
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 1),
              if (question == null)
                BlocBuilder<GetSingleQuestionBloc, GetSingleQuestionState>(
                  builder: (context, state) {
                    if (state is GetSingleQuestionLoadedState) {
                      return QuestionContent(
                        question: state.singleQuestion,
                        scrollController: scrollController,
                      );
                    }

                    return const PlatformProgressIndicator();
                  },
                )
              else
                BlocBuilder<FetchQuestionsBloc, FetchQuestionsState>(
                  builder: (context, state) {
                    List<ArticleEntity> articles = [];

                    if (state is QuestionsLoading) {
                      articles = state.oldArticles;
                    } else if (state is QuestionsLoaded) {
                      articles = state.articles;
                    }

                    return question != null
                        ? QuestionContent(
                            question: question,
                            questions: articles,
                            scrollController: scrollController,
                          )
                        : const PlatformProgressIndicator();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  ArticleEntity? _getQuestion(List<ArticleEntity> questions) =>
      questions.where((element) => element.id == widget.id).firstOrNull;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
