// ignore_for_file: prefer_final_locals, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/usecases/fetch_news_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

class FetchNewsBloc extends Bloc<FetchNewsEvent, FetchNewsState> {
  final FetchNewsUseCase fetchNews;
  int page = 1;

  FetchNewsBloc({required this.fetchNews}) : super(FetchNewsEmptyState()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<FetchNewsEvent>(
      _onEvent,
      transformer: bloc_concurrency.sequential(),
    );
  }

  FutureOr _onEvent(
    FetchNewsEvent event,
    Emitter emit,
  ) async {
    if (state is FetchNewsLoadingState) return;

    NewsEntity oldNews = NewsEntity(
      response: ResponseEntity(
        count: 0,
        update: 0,
        categories: null,
        articles: [],
      ),
    );

    if (state is FetchNewsLoadedState) {
      oldNews = (state as FetchNewsLoadedState).news;
    }

    emit(FetchNewsLoadingState(oldNews, isFirstFetch: page == 1));

    String _mapFailureToMessage(Failure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return 'Ошибка на сервере';
        case CacheFailure:
          return 'Ошибка обработки кэша';
        default:
          return 'Unexpected Error';
      }
    }

    final failureOrNews = await fetchNews(FetchNewsParams(
      page: page,
    ));

    failureOrNews.fold(
      (failure) {
        emit(FetchNewsLoadingError(
          message: _mapFailureToMessage(failure),
        ));
      },
      (news) {
        page++;

        /// Создание листа со всеми вкладками.
        List<String> tabs = ['Все', ...news.response.categories!];

        var newNews = (state as FetchNewsLoadingState).oldNews;
        newNews.response.articles.addAll(news.response.articles);

        emit(FetchNewsLoadedState(news: newNews, tabs: tabs));
      },
    );
  }
}

// Инам для выдачи NewsEntity Новости, Вопросы, Справочник.
enum NewsCodeEnum { news, quastion, catalog }

String newsCode(NewsCodeEnum codeEnum) {
  switch (codeEnum) {
    case NewsCodeEnum.news:
      return 'NEWS';
    case NewsCodeEnum.quastion:
      return 'QUASTION';
    default:
      return 'CATALOG';
  }
}

class FetchNewsEvent {
  const FetchNewsEvent();
}

abstract class FetchNewsState extends Equatable {
  const FetchNewsState();

  @override
  List<Object?> get props => [];
}

class FetchNewsEmptyState extends FetchNewsState {}

class FetchNewsLoadingState extends FetchNewsState {
  final NewsEntity oldNews;

  final bool isFirstFetch;

  const FetchNewsLoadingState(this.oldNews, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldNews];
}

class FetchNewsLoadedState extends FetchNewsState {
  final NewsEntity news;

  final List<String> tabs;
  const FetchNewsLoadedState({
    required this.news,
    required this.tabs,
  });

  @override
  List<Object?> get props => [news, tabs];
}

class FetchNewsLoadingError extends FetchNewsState {
  final String message;

  const FetchNewsLoadingError({required this.message});

  @override
  List<Object?> get props => [message];
}
