import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/question_preview.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/on_hover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuestionsList extends StatefulWidget {
  final List<ArticleEntity> questions;
  final List<String> tabs;
  final int currentIndex;

  const QuestionsList({
    Key? key,
    required this.questions,
    required this.tabs,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<QuestionsList> createState() => _QuestionsListState();
}

class _QuestionsListState extends State<QuestionsList> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    setupScrollController(context);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (widget.currentIndex == 0) {
            context.read<FetchQuestionsBloc>().add(const FetchQaustionsEvent());
          } else {
            context.read<FetchQuestionsBloc>().add(FetchQaustionsEventBy(widget.tabs[widget.currentIndex]));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = _getQuestionsByCategory();

    return ListView.separated(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      shrinkWrap: true,
      itemCount: questions.length,
      itemBuilder: (context, index) => _questionBuilderItem(questions[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }

  Widget _questionBuilderItem(ArticleEntity question) {
    return OnHover(
      builder: (isHovered) {
        return Opacity(
          opacity: isHovered ? 0.6 : 1,
          child: QuestionPreview(
            text: question.header,
            onTap: () {
              context.goNamed(
                NavigationRouteNames.question,
                params: {'fid': question.id},
              );
            },
          ),
        );
      },
    );
  }

  List<ArticleEntity> _getQuestionsByCategory() =>
      widget.questions.where((question) => question.category == widget.tabs[widget.currentIndex]).toList();
}
