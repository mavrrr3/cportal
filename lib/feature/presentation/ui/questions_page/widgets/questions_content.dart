import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/question_row.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuestionsContent extends StatefulWidget {
  final List<ArticleEntity> articles;
  final List<String> tabs;
  final int currentIndex;

  const QuestionsContent({
    Key? key,
    required this.articles,
    required this.tabs,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<QuestionsContent> createState() => _QuestionsContentState();
}

class _QuestionsContentState extends State<QuestionsContent> {
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
            context
                .read<FetchQuestionsBloc>()
                .add(FetchQaustionsEventBy(widget.tabs[widget.currentIndex]));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget builderItem(
      List<ArticleEntity> articles,
      List<String> tabs,
      int index,
    ) {
      if (articles[index].category == tabs[widget.currentIndex]) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: QuestionRow(
            text: articles[index].header,
            onTap: () {
              GoRouter.of(context).pushNamed(
                NavigationRouteNames.questionArticlePage,
                params: {'fid': articles[index].id},
              );
            },
          ),
        );
      }

      return const SizedBox();
    }

    return SingleChildScrollView(
      controller: scrollController,
      dragStartBehavior: DragStartBehavior.down,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.articles.length,
            itemBuilder: (context, index) {
              return builderItem(widget.articles, widget.tabs, index);
            },
          ),
        ],
      ),
    );
  }
}