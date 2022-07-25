import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_news_bloc/get_single_news_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/single_article/single_news_article_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/news_page/articles/single_article/single_news_article_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';

class NewsArticlePageFromSearch extends StatelessWidget {
  final String id;
  const NewsArticlePageFromSearch({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetSingleNewsBloc>(context, listen: false)
        .add(GetSingleNewsEventImpl(id));

    return Scaffold(
      body: Swipe(
        onSwipeRight: () {
          if (!kIsWeb) {
            context.pop();
          }
        },
        child: BlocBuilder<GetSingleNewsBloc, GetSingleNewsState>(
          builder: (context, state) {
            if (state is GetSingleNewsLoadedState) {
              return kIsWeb
                  ? SingleNewsArticleWeb(article: state.singleNews)
                  : SingleNewsArticleMobile(article: state.singleNews);
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
