import 'package:cportal_flutter/common/util/custom_padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:flutter/material.dart';

import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_content.dart';

class ScrollableNewsList extends StatelessWidget {
  final List<ArticleEntity> _articles;
  final TabController _tabController;
  final List<String> _categories;

  const ScrollableNewsList({
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
              child: NewsContent(
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
