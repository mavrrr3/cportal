import 'dart:developer';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/questions/fetch_questions_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/questions/fetch_questions_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class FetchQuestionsBloc extends Bloc<QuestionsEvent, FetchQuestionsState> {
  final FetchQuestionsUseCase fetchQaustions;
  final FetchQuestionsByCategoryUseCase fetchQuestionsByCategory;

  int pageAll = 1;

  List<String> questionTabs = [];

  FetchQuestionsBloc({
    required this.fetchQaustions,
    required this.fetchQuestionsByCategory,
  }) : super(QuestionsEmptyState()) {
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

      final failureOrQuestions = await fetchQaustions(FetchQuestionsParams(
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
        final tabsFromCache = await fetchQaustions.fetchQuestionCategories();

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

      failureOrQuestions.fold(failureToMessage, loadedNewsToArticles);
    });

    on<FetchQaustionsEventBy>((event, emit) async {
      int pageByCategory = 1;

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

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();
}

class FetchQaustionsEvent extends QuestionsEvent {
  const FetchQaustionsEvent();

  @override
  List<Object?> get props => [];
}

class FetchQaustionsEventBy extends QuestionsEvent {
  final String category;
  const FetchQaustionsEventBy(this.category);

  @override
  List<Object?> get props => [category];
}

abstract class FetchQuestionsState extends Equatable {
  const FetchQuestionsState();

  @override
  List<Object?> get props => [];
}

class QuestionsEmptyState extends FetchQuestionsState {}

class QuestionsLoading extends FetchQuestionsState {
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

class QaustionsLoaded extends FetchQuestionsState {
  final List<ArticleEntity> articles;
  final List<String> tabs;
  const QaustionsLoaded({
    required this.articles,
    required this.tabs,
  });

  @override
  List<Object?> get props => [articles, tabs];
}
