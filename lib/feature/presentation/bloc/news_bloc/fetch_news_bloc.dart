import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/news/fetch_news_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/news/fetch_news_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class FetchNewsBloc extends Bloc<FetchNewsEvent, FetchNewsState> {
  final FetchNewsUseCase fetchNews;

  final FetchNewsByCategoryUseCase fetchNewsByCategory;

  int pageAll = 1;
  Map pageByCategory = <String, int>{};
  List<String> newsTabs = ['Все'];

  FetchNewsBloc({
    required this.fetchNews,
    required this.fetchNewsByCategory,
  }) : super(NewsEmptyState()) {
    on<FetchAllNewsEvent>((event, emit) async {
      var oldArticles = <ArticleEntity>[];

      if (state is NewsLoading) return;

      if (state is NewsLoaded) {
        oldArticles = (state as NewsLoaded).articles;
      }

      emit(NewsLoading(
        oldArticles,
        newsTabs,
        isFirstFetch: pageAll == 1,
      ));

      final failureOrNews = await fetchNews(FetchNewsParams(
        page: pageAll,
      ));

      if (!kIsWeb) {
        final tabsFromCache = await fetchNews.fetchCategories();

        if (tabsFromCache.isNotEmpty) {
          for (final tab in tabsFromCache) {
            if (!newsTabs.contains(tab)) {
              newsTabs.add(tab);
            }
          }
        }
      }

      String failureToMessage(Failure failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return 'Ошибка на сервере';
          case CacheFailure:
            return 'Ошибка обработки кэша';
          default:
            return 'Unexpected Error';
        }
      }

      void loadedNewsToArticles(NewsEntity news) {
        pageAll++;
        final articles = (state as NewsLoading).oldArticles;
        // ignore: cascade_invocations
        articles.addAll(news.response.articles);

        // Создание листа со всеми вкладками.
        for (final tab in news.response.categories!) {
          if (!newsTabs.contains(tab)) {
            newsTabs.add(tab);
          }
        }
        for (int count = 0; count < newsTabs.length; count++) {
          if (pageByCategory.length != newsTabs.length) {
            pageByCategory.addAll(<String, int>{newsTabs[count]: 1});
          }
        }

        emit(NewsLoaded(articles: articles, tabs: newsTabs));
      }

      failureOrNews.fold(failureToMessage, loadedNewsToArticles);
    });

    on<FetchNewsEventBy>((event, emit) async {
      if (state is NewsLoading) return;

      var oldArticles = <ArticleEntity>[];

      if (state is NewsLoaded) {
        oldArticles = (state as NewsLoaded).articles;
      }

      emit(NewsLoading(
        oldArticles,
        newsTabs,
        isFirstFetch: pageByCategory[event.category] == 1,
      ));

      final failureOrNews = await fetchNewsByCategory(
        FetchNewsByCategoryParams(
          category: event.category,
          page: pageByCategory[event.category] as int,
        ),
      );

      String failureToMessage(Failure failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return 'Ошибка на сервере';
          case CacheFailure:
            return 'Ошибка обработки кэша';
          default:
            return 'Unexpected Error';
        }
      }

      var articles = (state as NewsLoading).oldArticles;

      void loadedNewsToArticles(NewsEntity news) {
        pageByCategory[event.category]++;
        if (state is NewsLoading) {
          articles = (state as NewsLoading).oldArticles;

          // ignore: cascade_invocations
          articles.addAll(news.response.articles);
        }
      }

      failureOrNews.fold(failureToMessage, loadedNewsToArticles);

      emit(NewsLoaded(articles: articles, tabs: newsTabs));
    });
  }
}

abstract class FetchNewsEvent extends Equatable {
  const FetchNewsEvent();
}

class FetchAllNewsEvent extends FetchNewsEvent {
  const FetchAllNewsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNewsEventBy extends FetchNewsEvent {
  final String category;
  const FetchNewsEventBy(this.category);

  @override
  List<Object?> get props => [category];
}

abstract class FetchNewsState extends Equatable {
  const FetchNewsState();

  @override
  List<Object?> get props => [];
}

class NewsEmptyState extends FetchNewsState {}

class NewsLoading extends FetchNewsState {
  final List<ArticleEntity> oldArticles;
  final bool isFirstFetch;
  final List<String> tabs;

  const NewsLoading(this.oldArticles, this.tabs, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldArticles, tabs, isFirstFetch];
}

class NewsLoaded extends FetchNewsState {
  final List<ArticleEntity> articles;
  final List<String> tabs;
  const NewsLoaded({
    required this.articles,
    required this.tabs,
  });

  ArticleEntity? singleArticle(String id) {
    final List<ArticleEntity> newsListWithId =
        articles.where((element) => element.id == id).toList();

    return newsListWithId.isEmpty ? null : newsListWithId.first;
  }

  @override
  List<Object?> get props => [articles, tabs];
}

class NewsLoadingError extends FetchNewsState {
  final String message;

  const NewsLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
