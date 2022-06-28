import 'dart:developer';

import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/quastions_bloc/fetch_quastions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/quastions_page/widgets/quastion_row.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuastionsContent extends StatelessWidget {
  final List<ArticleEntity> articles;
  final List<String> tabs;
  final int currentIndex;

  final scrollController = ScrollController();

  QuastionsContent({
    Key? key,
    required this.articles,
    required this.tabs,
    required this.currentIndex,
  }) : super(key: key);

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (currentIndex == 0) {
            log('_setupScrollController_setupScrollController_setupScrollController');
            context.read<FetchQuastionsBloc>().add(const FetchQaustionsEvent());
          } else {
            log('222222_setupScrollController_setupScrollController_setupScrollController');
            context
                .read<FetchQuastionsBloc>()
                .add(FetchQaustionsEventBy(tabs[currentIndex]));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    Widget builderItem(
      List<ArticleEntity> articles,
      List<String> tabs,
      int index,
    ) {
      if (articles[index].category == tabs[currentIndex]) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: QuastionRow(
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

    log('================ $tabs ================================');

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
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return builderItem(articles, tabs, index);
            },
          ),
        ],
      ),
    );
  }
}
