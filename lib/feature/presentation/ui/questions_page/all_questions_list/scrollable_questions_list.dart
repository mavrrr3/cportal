import 'package:cportal_flutter/common/util/custom_padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/questions_list.dart';
import 'package:flutter/material.dart';

class ScrollableQuestionsList extends StatelessWidget {
  final List<ArticleEntity> articles;
  final TabController tabController;
  final List<String> categories;

  const ScrollableQuestionsList({
    Key? key,
    required this.articles,
    required this.tabController,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: List.generate(
          categories.length,
          (index) {
            return Padding(
              padding: getHorizontalPadding(context),
              child: QuestionsList(
                questions: articles,
                tabs: categories,
                currentIndex: tabController.index,
              ),
            );
          },
        ),
      ),
    );
  }
}
