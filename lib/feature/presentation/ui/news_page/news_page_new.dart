import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_cubit.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/widgets/tab_bar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsPageNew extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  NewsPageNew({super.key});

  void setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          context.read<FetchNewsCubit>().loadNews();
        }
      }
    });
  }

  int oneOrZero(bool isLoading) {
    return isLoading ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    final double width = MediaQuery.of(context).size.width;

    void _onArticleSelected(String id) {
      GoRouter.of(context).pushNamed(
        NavigationRouteNames.newsArticlePage,
        params: {'fid': id},
      );
    }

    return BlocBuilder<FetchNewsCubit, NewsState>(builder: (context, state) {
      List<ArticleEntity> articles = [];

      if (state is NewsLoading && state.isFirstFetch) {
        return const Center(child: CircularProgressIndicator(strokeWidth: 3));
      } else if (state is NewsLoading) {
        articles = state.oldArticles;
      } else if (state is NewsLoaded) {
        articles = state.articles;
      }

      return Scaffold(
        appBar: PreferredSize(
          child: SafeArea(
            child: TabBarWidget(
              title: AppLocalizations.of(context)!.news,
              categoryTitle: const [
                'Все',
              ],
              currentIndex: 0,
              onTap: (index) {},
            ),
          ),
          preferredSize: Size(width, 114),
        ),
        body: Padding(
          padding: getHorizontalPadding(context),
          child: SingleChildScrollView(
            controller: _scrollController,
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
                    return _NewsCard(
                      width,
                      item: articles[index],
                      onTap: () => _onArticleSelected(articles[index].id),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _NewsCard extends StatelessWidget {
  final double width;
  final ArticleEntity item;
  final Function() onTap;
  const _NewsCard(
    this.width, {
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
