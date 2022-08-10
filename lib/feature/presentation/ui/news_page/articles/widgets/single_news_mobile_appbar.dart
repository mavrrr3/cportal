import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SingleNewsMobileAppBar extends StatelessWidget {
  final ArticleEntity article;

  const SingleNewsMobileAppBar({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return SliverAppBar(
      backgroundColor: theme.background,
      expandedHeight: 176,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            ExtendedImage.network(
              '${AppConfig.imagesUrl}/${article.image}',
              fit: BoxFit.cover,
              cache: true,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: theme.black!.withOpacity(0.42),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    enableFeedback: false,
                    icon: Icon(Icons.arrow_back, color: theme.white),
                    iconSize: 26,
                    onPressed: context.pop,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
