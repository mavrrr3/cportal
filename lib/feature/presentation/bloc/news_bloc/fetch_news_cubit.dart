import 'dart:developer';

import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_news_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_news_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchNewsCubit extends Cubit<NewsState> {
  final FetchNewsUseCase fetchNews;
  final FetchNewsByCategoryUseCase fetchNewsByCategory;

  int page = 1;
  List<String> tabs = ['Все'];

  FetchNewsCubit({
    required this.fetchNews,
    required this.fetchNewsByCategory,
  }) : super(NewsEmpty());

  Future<void> loadNews() async {
    if (state is NewsLoading) return;

    var oldArticles = <ArticleEntity>[];

    if (state is NewsLoaded) {
      oldArticles = (state as NewsLoaded).articles;
    }

    emit(NewsLoading(oldArticles, isFirstFetch: page == 1));

    final failureOrNews = await fetchNews(FetchNewsParams(
      page: page,
    ));

    String _failureToMessage(Failure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return 'Ошибка на сервере';
        case CacheFailure:
          return 'Ошибка обработки кэша';
        default:
          return 'Unexpected Error';
      }
    }

    void _loadedNewsToArticles(NewsEntity news) {
      page++;
      final articles = (state as NewsLoading).oldArticles;
      // ignore: cascade_invocations
      articles.addAll(news.response.articles);
      log('Загрузилось ${articles.length} статей');

      /// Создание листа со всеми вкладками.
      tabs.addAll(news.response.categories!);

      emit(NewsLoaded(articles: articles, tabs: tabs));
    }

    failureOrNews.fold(_failureToMessage, _loadedNewsToArticles);
  }

  Future<void> loadNewsByCategory(String category) async {
    if (state is NewsLoading) return;

    var oldArticles = <ArticleEntity>[];

    if (state is NewsLoaded) {
      oldArticles = (state as NewsLoaded).articles;
    }

    emit(NewsLoading(oldArticles, isFirstFetch: page == 1));

    final failureOrNews = await fetchNewsByCategory(
      FetchNewsByCategoryParams(
        category: category,
        page: page,
      ),
    );

    String _failureToMessage(Failure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return 'Ошибка на сервере';
        case CacheFailure:
          return 'Ошибка обработки кэша';
        default:
          return 'Unexpected Error';
      }
    }

    void _loadedNewsToArticles(NewsEntity news) {
      page++;
      final articles = (state as NewsLoading).oldArticles;
      // ignore: cascade_invocations
      articles.addAll(news.response.articles);
      log('Загрузилось ${articles.length} статей из категории $category');

      /// Создание листа со всеми вкладками.

      emit(NewsLoaded(articles: articles, tabs: tabs));
    }

    failureOrNews.fold(_failureToMessage, _loadedNewsToArticles);
  }
}

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsEmpty extends NewsState {}

class NewsLoading extends NewsState {
  final List<ArticleEntity> oldArticles;
  final bool isFirstFetch;

  const NewsLoading(this.oldArticles, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldArticles];
}

class NewsLoaded extends NewsState {
  final List<ArticleEntity> articles;
  final List<String> tabs;

  const NewsLoaded({
    required this.articles,
    required this.tabs,
  });

  @override
  List<Object?> get props => [articles, tabs];
}

class NewsLoadingError extends NewsState {
  final String message;

  const NewsLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
