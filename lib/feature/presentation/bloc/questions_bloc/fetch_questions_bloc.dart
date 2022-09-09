import 'dart:developer';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/questions/fetch_questions_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/questions/fetch_questions_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class FetchQuestionsBloc extends Bloc<QuestionsEvent, FetchQuestionsState> {
  final FetchQuestionsUseCase fetchQaustions;
  final FetchQuestionsByCategoryUseCase fetchQuestionsByCategory;

  int pageAll = 1;
  Map pageByCategory = <String, int>{};

  List<String> questionTabs = [];

  FetchQuestionsBloc({
    required this.fetchQaustions,
    required this.fetchQuestionsByCategory,
  }) : super(QuestionsEmptyState()) {
    on<FetchQuestionsEvent>(
      (event, emit) async {
        var oldArticles = <ArticleEntity>[];
        if (state is QuestionsLoading) return;

        if (state is QuestionsLoaded) {
          oldArticles = (state as QuestionsLoaded).articles;
        }

        emit(QuestionsLoading(
          oldArticles,
          questionTabs,
          isFirstFetch: pageAll == 1,
        ));

        final failureOrQuestions = await fetchQaustions(FetchQuestionsParams(
          page: pageAll,
        ));

        if (!kIsWeb) {
          final tabsFromCache = await fetchQaustions.fetchQuestionCategories();

          if (tabsFromCache.isNotEmpty) {
            for (final tab in tabsFromCache) {
              if (!questionTabs.contains(tab)) {
                questionTabs.add(tab);
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

        void loadedNewsToArticles(NewsEntity questions) {
          pageAll++;
          final articles = (state as QuestionsLoading).oldArticles;
          // ignore: cascade_invocations
          articles.addAll(questions.response.articles);
          log('Загрузилось ${articles.length} вопросов');
          log('Загрузилось ${questions.response.categories!} вопросов');

          // Создание листа со всеми вкладками.
          for (final tab in questions.response.categories!) {
            if (!questionTabs.contains(tab)) {
              questionTabs.add(tab);
            }
          }
          for (int count = 0; count < questionTabs.length; count++) {
            if (pageByCategory.length != questionTabs.length) {
              pageByCategory.addAll(<String, int>{questionTabs[count]: 1});
            }
          }

          emit(QuestionsLoaded(articles: articles, tabs: questionTabs));
        }

        failureOrQuestions.fold(failureToMessage, loadedNewsToArticles);
      },
      transformer: bloc_concurrency.droppable(),
    );

    on<FetchQaustionsEventBy>(
      (event, emit) async {
        if (state is QuestionsLoading) return;

        var oldArticles = <ArticleEntity>[];

        if (state is QuestionsLoaded) {
          oldArticles = (state as QuestionsLoaded).articles;
        }

        emit(QuestionsLoading(
          oldArticles,
          questionTabs,
          isFirstFetch: pageByCategory[event.category] == 1,
        ));
        log('+++++ event.category ${event.category} +++++');
        final failureOrNews = await fetchQuestionsByCategory(
          FetchQuestionsByCategoryParams(
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

        void loadedNewsToArticles(NewsEntity news) {
          pageByCategory[event.category]++;

          final articles = (state as QuestionsLoading).oldArticles;
          // ignore: cascade_invocations
          articles.addAll(news.response.articles);

          log('Загрузилось ${articles.length} статей из категории ${event.category}');

          /// Создание листа со всеми вкладками.

          emit(QuestionsLoaded(articles: articles, tabs: questionTabs));
        }

        failureOrNews.fold(failureToMessage, loadedNewsToArticles);
      },
      transformer: bloc_concurrency.droppable(),
    );
  }
}

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();
}

class FetchQuestionsEvent extends QuestionsEvent {
  const FetchQuestionsEvent();

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

class QuestionsLoaded extends FetchQuestionsState {
  final List<ArticleEntity> articles;
  final List<String> tabs;

  const QuestionsLoaded({
    required this.articles,
    required this.tabs,
  });

  @override
  List<Object?> get props => [articles, tabs];
}

class QuestionLoadingError extends FetchQuestionsState {
  final String message;

  const QuestionLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
