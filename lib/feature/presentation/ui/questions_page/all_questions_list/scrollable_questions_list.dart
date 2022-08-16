import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/questions_list.dart';
import 'package:flutter/material.dart';

class ScrollableQuestionsList extends StatelessWidget {
  final List<ArticleEntity> _articles;
  final TabController _tabController;
  final List<String> _categories;

  const ScrollableQuestionsList({
    Key? key,
    required List<ArticleEntity> articles,
    required TabController tabController,
    required List<String> categories,
  })  : _articles = articles,
        _tabController = tabController,
        _categories = categories,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: List.generate(
          _categories.length,
          (index) {
            return Padding(
              padding: getHorizontalPadding(context),
              child: QuestionsList(
                articles: _articles,
                tabs: _categories,
                currentIndex: _tabController.index,
              ),
            );
          },
        ),
      ),
    );
  }
}
