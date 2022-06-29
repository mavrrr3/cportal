import 'dart:developer';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/news/fetch_news_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/news/fetch_news_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/questions/fetch_questions_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/questions/fetch_questions_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class FetchNewsBloc extends Bloc<FetchNewsEvent, FetchNewsState> {
  final FetchNewsUseCase fetchNews;
  final FetchQuestionsUseCase fetchQaustions;
  final FetchNewsByCategoryUseCase fetchNewsByCategory;
  final FetchQuestionsByCategoryUseCase fetchQuestionsByCategory;

  int pageAll = 1;
  int pageByCategory = 1;
  List<String> tabs = ['Все'];
  List<String> questionTabs = [];

  FetchNewsBloc({
    required this.fetchNews,
    required this.fetchNewsByCategory,
    required this.fetchQaustions,
    required this.fetchQuestionsByCategory,
  }) : super(NewsEmptyState()) {
    on<FetchAllNewsEvent>((event, emit) async {
      var oldArticles = <ArticleEntity>[];

      if (state is NewsLoaded) {
        oldArticles = (state as NewsLoaded).articles;
      }

      emit(NewsLoading(oldArticles, tabs, isFirstFetch: pageAll == 1));

      final failureOrNews = await fetchNews(FetchNewsParams(
        page: pageAll,
      ));

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

      if (!kIsWeb) {
        final tabsFromCache = await fetchNews.fetchCategories();

        if (tabsFromCache.isNotEmpty) {
          for (final tab in tabsFromCache) {
            if (!tabs.contains(tab)) {
              tabs.add(tab);
            }
          }
        }
      }
      void loadedNewsToArticles(NewsEntity news) {
        pageAll++;
        final articles = (state as NewsLoading).oldArticles;
        // ignore: cascade_invocations
        articles.addAll(news.response.articles);

        // Создание листа со всеми вкладками.
        for (final tab in news.response.categories!) {
          if (!tabs.contains(tab)) {
            tabs.add(tab);
          }
        }

        emit(NewsLoaded(articles: articles, tabs: tabs));
      }

      failureOrNews.fold(failureToMessage, loadedNewsToArticles);
    });

    on<FetchNewsEventBy>((event, emit) async {
      if (state is NewsLoading) return;

      var oldArticles = <ArticleEntity>[];

      if (state is NewsLoaded) {
        oldArticles = (state as NewsLoaded).articles;
      }

      emit(NewsLoading(oldArticles, tabs, isFirstFetch: pageByCategory == 1));

      final failureOrNews = await fetchNewsByCategory(
        FetchNewsByCategoryParams(
          category: event.category,
          page: pageByCategory,
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

      void loadedNewsToArticles(NewsEntity news) {
        pageByCategory++;
        final articles = (state as NewsLoading).oldArticles;
        // ignore: cascade_invocations
        articles.addAll(news.response.articles);

        /// Создание листа со всеми вкладками.

        emit(NewsLoaded(articles: articles, tabs: tabs));
      }

      failureOrNews.fold(failureToMessage, loadedNewsToArticles);
    });

    on<FetchQaustionsEvent>((event, emit) async {
      var oldArticles = <ArticleEntity>[];

      if (state is QaustionsLoaded) {
        oldArticles = (state as QaustionsLoaded).articles;
      }

      emit(QuestionsLoading(
        oldArticles,
        questionTabs,
        isFirstFetch: pageAll == 1,
      ));

      final failureOrNews = await fetchQaustions(FetchQuestionsParams(
        page: pageAll,
      ));

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

      if (!kIsWeb) {
        final tabsFromCache = await fetchNews.fetchCategories();

        if (tabsFromCache.isNotEmpty) {
          for (final tab in tabsFromCache) {
            if (!questionTabs.contains(tab)) {
              questionTabs.add(tab);
            }
          }
          log('+++++++++++Questions tabs из КеШа++ $tabsFromCache ++Questions tabs из КеШа+++++++++++++');
        }
      }
      void loadedNewsToArticles(NewsEntity questions) {
        pageAll++;
        final articles = (state as QuestionsLoading).oldArticles;
        // ignore: cascade_invocations
        articles.addAll(questions.response.articles);
        log('Загрузилось ${articles.length} статей');
        log('Загрузилось ${questions.response.categories!} статей');

        // Создание листа со всеми вкладками.
        for (final tab in questions.response.categories!) {
          if (!questionTabs.contains(tab)) {
            questionTabs.add(tab);
          }
        }

        emit(QaustionsLoaded(articles: articles, tabs: questionTabs));
      }

      failureOrNews.fold(failureToMessage, loadedNewsToArticles);
    });

    on<FetchQaustionsEventBy>((event, emit) async {
      if (state is QuestionsLoading) return;

      var oldArticles = <ArticleEntity>[];

      if (state is QaustionsLoaded) {
        oldArticles = (state as QaustionsLoaded).articles;
      }

      emit(QuestionsLoading(
        oldArticles,
        questionTabs,
        isFirstFetch: pageByCategory == 1,
      ));
      log('+++++ event.category ${event.category} +++++');
      final failureOrNews = await fetchQuestionsByCategory(
        FetchQuestionsByCategoryParams(
          category: event.category,
          page: pageByCategory,
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

      void loadedNewsToArticles(NewsEntity news) {
        pageByCategory++;
        final articles = (state as QuestionsLoading).oldArticles;
        // ignore: cascade_invocations
        articles.addAll(news.response.articles);

        log('Загрузилось ${articles.length} статей из категории ${event.category}');

        /// Создание листа со всеми вкладками.

        emit(QaustionsLoaded(articles: articles, tabs: questionTabs));
      }

      failureOrNews.fold(failureToMessage, loadedNewsToArticles);
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

class FetchQaustionsEvent extends FetchNewsEvent {
  const FetchQaustionsEvent();

  @override
  List<Object?> get props => [];
}

class FetchQaustionsEventBy extends FetchNewsEvent {
  final String category;
  const FetchQaustionsEventBy(this.category);

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

  @override
  List<Object?> get props => [articles, tabs];
}

class NewsLoadingError extends FetchNewsState {
  final String message;

  const NewsLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}

class QuestionsLoading extends FetchNewsState {
  final List<ArticleEntity> oldArticles;
  final bool isFirstFetch;
  final List<String> tabs;

  const QuestionsLoading(
    this.oldArticles,
    this.tabs, {
    this.isFirstFetch = false,
  });

  @override
  List<Object?> get props => [oldArticles, tabs, isFirstFetch];
}

class QaustionsLoaded extends FetchNewsState {
  final List<ArticleEntity> articles;
  final List<String> tabs;
  const QaustionsLoaded({
    required this.articles,
    required this.tabs,
  });

  @override
  List<Object?> get props => [articles, tabs];
}
