import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:flutter/material.dart';

class NewsArticlePage extends StatelessWidget {
  const NewsArticlePage({
    Key? key,
    required this.article,
  }) : super(key: key);
  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
