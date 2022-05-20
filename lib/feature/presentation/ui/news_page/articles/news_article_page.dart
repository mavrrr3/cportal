import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/desktop_menu.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_card_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/news_horizontal_scroll.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:swipe/swipe.dart';

final DateFormat _outputFormat = DateFormat('d MMMM y, H:m', 'ru');

class NewsArticlePage extends StatelessWidget {
  final String id;
  const NewsArticlePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late ArticleEntity article;
    return BlocBuilder<FetchNewsBloc, FetchNewsState>(
      builder: (context, state) {
        if (state is FetchNewsLoadedState) {
          for (var element in state.news.article) {
            element.id == id;
            article = element;
          }

          return Swipe(
            onSwipeRight: () => GoRouter.of(context).pop(),
            child: Scaffold(
              body: !ResponsiveWrapper.of(context).isLargerThan(TABLET)
                  ? _Mobile(
                      item: article,
                      state: state,
                    )
                  : _Web(
                      item: article,
                      state: state,
                    ),
            ),
          );
        }

        /// TODO: Отработать другие стейты
        return const SizedBox();
      },
    );
  }
}

class _Mobile extends StatelessWidget {
  const _Mobile({
    Key? key,
    required this.item,
    required this.state,
  }) : super(key: key);
  final ArticleEntity item;
  final FetchNewsLoadedState state;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: ResponsiveConstraints(
        constraint: const BoxConstraints(maxWidth: 640),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: theme.backgroundColor,
              expandedHeight: 176,
              automaticallyImplyLeading: false,
              leading: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                enableFeedback: false,
                icon: const Icon(Icons.arrow_back),
                iconSize: 24,
                onPressed: () => GoRouter.of(context).pop(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: ExtendedImage.network(
                  item.image,
                  fit: BoxFit.cover,
                  cache: true,
                ),
              ),
            ),

            /// Колонка с контентом статьи
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.header,
                      style: theme.textTheme.headline3,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _outputFormat.format(
                        item.dateShow,
                      ),
                      style: theme.textTheme.bodyText1,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      item.description,
                      style: theme.textTheme.headline6,
                    ),
                    const SizedBox(height: 20),
                    NewsHorizontalScroll(
                      items: state.news.article,
                      isTextVisible: false,
                      currentArticle: item,
                      onTap: (index) {
                        GoRouter.of(context).pop();
                        GoRouter.of(context).pushNamed(
                          NavigationRouteNames.newsArticlePage,
                          extra: index,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Web extends StatefulWidget {
  const _Web({
    Key? key,
    required this.item,
    required this.state,
  }) : super(key: key);
  final ArticleEntity item;
  final FetchNewsLoadedState state;

  @override
  State<_Web> createState() => _WebState();
}

class _WebState extends State<_Web> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    void _contentInit(BuildContext context) {
      return BlocProvider.of<FetchNewsBloc>(context, listen: false)
          .add(const FetchNewsEventImpl(newsCodeEnum: NewsCodeEnum.news));
    }

    List<ArticleEntity> articlesToRecomendations(String id) {
      List<ArticleEntity> articles = [];
      for (var element in widget.state.news.article) {
        element.id == id;
        articles.add(element);
      }

      return articles;
    }

    ArticleEntity article = widget.item;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DesktopMenu(
          currentIndex: 1,
          onChange: (index) {
            setState(() {
              changePage(context, index);
            });
          },
        ),
        SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ResponsiveConstraints(
              constraint: const BoxConstraints(maxWidth: 704),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _contentInit(context);
                        setState(() {
                          GoRouter.of(context).pop();
                        });
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/back_arrow.svg',
                            width: 16,
                            color: theme.primaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppLocalizations.of(context)!.news,
                            style: theme.textTheme.headline5!.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 310,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                article.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            article.header,
                            style: theme.textTheme.headline3,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _outputFormat.format(
                              widget.item.dateShow,
                            ),
                            style: theme.textTheme.bodyText1,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            article.description,
                            style: theme.textTheme.headline6,
                          ),
                          const SizedBox(height: 40),
                          Wrap(
                            runSpacing: 16,
                            spacing: 16,
                            children: List.generate(
                                articlesToRecomendations(article.id).length,
                                (i) {
                              return NewsCardItem(
                                width: 312,
                                height: 152,
                                imgPath: articlesToRecomendations(article.id)[i]
                                    .image,
                                title: articlesToRecomendations(article.id)[i]
                                    .header,
                                dateTime: _outputFormat.format(
                                  articlesToRecomendations(article.id)[i]
                                      .dateShow,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
