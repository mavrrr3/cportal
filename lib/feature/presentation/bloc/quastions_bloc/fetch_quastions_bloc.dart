import 'dart:developer';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/quastions/fetch_quastions_by_category_usecase.dart';
import 'package:cportal_flutter/feature/domain/usecases/quastions/fetch_quastions_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class FetchQuastionsBloc extends Bloc<QuastionsEvent, FetchQuastionsState> {
  final FetchQuastionsUseCase fetchQaustions;
  final FetchQuastionsByCategoryUseCase fetchQuastionsByCategory;

  int pageAll = 1;

  List<String> quastionTabs = [];

  FetchQuastionsBloc({
    required this.fetchQaustions,
    required this.fetchQuastionsByCategory,
  }) : super(QuastionsEmptyState()) {
    on<FetchQaustionsEvent>((event, emit) async {
      var oldArticles = <ArticleEntity>[];

      if (state is QaustionsLoaded) {
        oldArticles = (state as QaustionsLoaded).articles;
      }

      emit(QuastionsLoading(
        oldArticles,
        quastionTabs,
        isFirstFetch: pageAll == 1,
      ));

      final failureOrQuastions = await fetchQaustions(FetchQuastionsParams(
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
        final tabsFromCache = await fetchQaustions.fetchQuastionCategories();

        if (tabsFromCache.isNotEmpty) {
          for (final tab in tabsFromCache) {
            if (!quastionTabs.contains(tab)) {
              quastionTabs.add(tab);
            }
          }
          log('+++++++++++Quastions tabs из КеШа++ $tabsFromCache ++Quastions tabs из КеШа+++++++++++++');
        }
      }
      void loadedNewsToArticles(NewsEntity quastions) {
        pageAll++;
        final articles = (state as QuastionsLoading).oldArticles;
        // ignore: cascade_invocations
        articles.addAll(quastions.response.articles);
        log('Загрузилось ${articles.length} статей');
        log('Загрузилось ${quastions.response.categories!} статей');

        // Создание листа со всеми вкладками.
        for (final tab in quastions.response.categories!) {
          if (!quastionTabs.contains(tab)) {
            quastionTabs.add(tab);
          }
        }

        emit(QaustionsLoaded(articles: articles, tabs: quastionTabs));
      }

      failureOrQuastions.fold(failureToMessage, loadedNewsToArticles);
    });

    on<FetchQaustionsEventBy>((event, emit) async {
      int pageByCategory = 1;

      if (state is QuastionsLoading) return;

      var oldArticles = <ArticleEntity>[];

      if (state is QaustionsLoaded) {
        oldArticles = (state as QaustionsLoaded).articles;
      }

      emit(QuastionsLoading(
        oldArticles,
        quastionTabs,
        isFirstFetch: pageByCategory == 1,
      ));
      log('+++++ event.category ${event.category} +++++');
      final failureOrNews = await fetchQuastionsByCategory(
        FetchQuastionsByCategoryParams(
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
        final articles = (state as QuastionsLoading).oldArticles;
        // ignore: cascade_invocations
        articles.addAll(news.response.articles);

        log('Загрузилось ${articles.length} статей из категории ${event.category}');

        /// Создание листа со всеми вкладками.

        emit(QaustionsLoaded(articles: articles, tabs: quastionTabs));
      }

      failureOrNews.fold(failureToMessage, loadedNewsToArticles);
    });
  }
}

abstract class QuastionsEvent extends Equatable {
  const QuastionsEvent();
}

class FetchQaustionsEvent extends QuastionsEvent {
  const FetchQaustionsEvent();

  @override
  List<Object?> get props => [];
}

class FetchQaustionsEventBy extends QuastionsEvent {
  final String category;
  const FetchQaustionsEventBy(this.category);

  @override
  List<Object?> get props => [category];
}

abstract class FetchQuastionsState extends Equatable {
  const FetchQuastionsState();

  @override
  List<Object?> get props => [];
}

class QuastionsEmptyState extends FetchQuastionsState {}

class QuastionsLoading extends FetchQuastionsState {
  final List<ArticleEntity> oldArticles;
  final bool isFirstFetch;
  final List<String> tabs;

  const QuastionsLoading(
    this.oldArticles,
    this.tabs, {
    this.isFirstFetch = false,
  });

  @override
  List<Object?> get props => [oldArticles, tabs, isFirstFetch];
}

class QaustionsLoaded extends FetchQuastionsState {
  final List<ArticleEntity> articles;
  final List<String> tabs;
  const QaustionsLoaded({
    required this.articles,
    required this.tabs,
  });

  @override
  List<Object?> get props => [articles, tabs];
}
