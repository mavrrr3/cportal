import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/news_card_item.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final double width;
  final ArticleEntity item;
  final Function() onTap;
  const NewsCard(
    this.width, {
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLargerThenMobile(context)
          ? const EdgeInsets.only(bottom: 20, right: 20)
          : const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: NewsCardItem(
          width: width,
          height: 160,
          fontSize: 17,
          item: item,
        ),
      ),
    );
  }
}
