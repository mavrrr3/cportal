import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_template.dart';
import 'package:cportal_flutter/feature/presentation/ui/questions_page/widgets/question_preview.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/bottom_padding.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';

class QuestionContent extends StatelessWidget {
  final ArticleEntity question;
  final List<ArticleEntity> questions;

  const QuestionContent({
    Key? key,
    required this.question,
    this.questions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final nextArticle = _getNextQuestion();

    return Padding(
      padding: isLargerThenTablet(context)
          ? const EdgeInsets.only(left: 25)
          : const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.header,
            style: theme.textTheme.px32,
          ),
          SizedBox(height: isLargerThenTablet(context) ? 20 : 19),
          Column(
            children: List.generate(
              question.content.length,
              (index) => NewsTemplate.factory(
                context,
                question.content[index],
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (nextArticle != null)
            QuestionPreview(
              text: nextArticle.header,
              onTap: () {
                context.pushNamed(
                  NavigationRouteNames.question,
                  params: {'fid': nextArticle.id},
                );
              },
            ),
          const BottomPadding(),
        ],
      ),
    );
  }

  ArticleEntity? _getNextQuestion() => questions
      .where((article) => article.category == question.category)
      .skipWhile((article) => article.id != question.id)
      .skip(1)
      .firstOrNull;
}
